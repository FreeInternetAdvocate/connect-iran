//
// KeychainErrorHandlingTests.swift
// bitchatTests
//
// This is free and unencumbered software released into the public domain.
// For more information, see <https://unlicense.org>
//
// BCH-01-009: Tests for proper keychain error classification and handling

import Testing
import Foundation
@testable import bitchat

struct KeychainErrorHandlingTests {

    // MARK: - Error Classification Tests

    @Test func keychainReadResult_successIsNotRecoverable() throws {
        let result = KeychainReadResult.success(Data([1, 2, 3]))
        #expect(result.isRecoverableError == false)
    }

    @Test func keychainReadResult_itemNotFoundIsNotRecoverable() throws {
        let result = KeychainReadResult.itemNotFound
        #expect(result.isRecoverableError == false)
    }

    @Test func keychainReadResult_deviceLockedIsRecoverable() throws {
        let result = KeychainReadResult.deviceLocked
        #expect(result.isRecoverableError == true)
    }

    @Test func keychainReadResult_authenticationFailedIsRecoverable() throws {
        let result = KeychainReadResult.authenticationFailed
        #expect(result.isRecoverableError == true)
    }

    @Test func keychainReadResult_accessDeniedIsNotRecoverable() throws {
        let result = KeychainReadResult.accessDenied
        #expect(result.isRecoverableError == false)
    }

    @Test func keychainSaveResult_successIsNotRecoverable() throws {
        let result = KeychainSaveResult.success
        #expect(result.isRecoverableError == false)
    }

    @Test func keychainSaveResult_duplicateItemIsRecoverable() throws {
        let result = KeychainSaveResult.duplicateItem
        #expect(result.isRecoverableError == true)
    }

    @Test func keychainSaveResult_deviceLockedIsRecoverable() throws {
        let result = KeychainSaveResult.deviceLocked
        #expect(result.isRecoverableError == true)
    }

    @Test func keychainSaveResult_storageFullIsNotRecoverable() throws {
        let result = KeychainSaveResult.storageFull
        #expect(result.isRecoverableError == false)
    }

    // MARK: - Mock Keychain Error Simulation Tests

    @Test func mockKeychain_canSimulateReadErrors() throws {
        let keychain = MockKeychain()

        // Simulate access denied error
        keychain.simulatedReadError = .accessDenied
        let result = keychain.getIdentityKeyWithResult(forKey: "testKey")

        switch result {
        case .accessDenied:
            // Expected
            break
        default:
            throw KeychainTestError("Expected accessDenied, got \(result)")
        }
    }

    @Test func mockKeychain_canSimulateSaveErrors() throws {
        let keychain = MockKeychain()

        // Simulate storage full error
        keychain.simulatedSaveError = .storageFull
        let result = keychain.saveIdentityKeyWithResult(Data([1, 2, 3]), forKey: "testKey")

        switch result {
        case .storageFull:
            // Expected
            break
        default:
            throw KeychainTestError("Expected storageFull, got \(result)")
        }
    }

    @Test func mockKeychain_returnsItemNotFoundForMissingKey() throws {
        let keychain = MockKeychain()
        let result = keychain.getIdentityKeyWithResult(forKey: "nonExistentKey")

        switch result {
        case .itemNotFound:
            // Expected
            break
        default:
            throw KeychainTestError("Expected itemNotFound, got \(result)")
        }
    }

    @Test func mockKeychain_returnsSuccessForExistingKey() throws {
        let keychain = MockKeychain()
        let testData = Data([1, 2, 3, 4, 5])

        // First save the key
        _ = keychain.saveIdentityKey(testData, forKey: "existingKey")

        // Now read it back
        let result = keychain.getIdentityKeyWithResult(forKey: "existingKey")

        switch result {
        case .success(let data):
            #expect(data == testData)
        default:
            throw KeychainTestError("Expected success, got \(result)")
        }
    }

    @Test func mockKeychain_saveWithResultStoresData() throws {
        let keychain = MockKeychain()
        let testData = Data([10, 20, 30])

        let saveResult = keychain.saveIdentityKeyWithResult(testData, forKey: "newKey")

        switch saveResult {
        case .success:
            // Verify data was stored
            let readResult = keychain.getIdentityKeyWithResult(forKey: "newKey")
            switch readResult {
            case .success(let data):
                #expect(data == testData)
            default:
                throw KeychainTestError("Expected to read back saved data")
            }
        default:
            throw KeychainTestError("Expected save success, got \(saveResult)")
        }
    }

    // MARK: - NoiseEncryptionService Integration Tests

    @Test func noiseEncryptionService_generatesNewIdentityWhenMissing() throws {
        let keychain = MockKeychain()

        // Create service with empty keychain - should generate new identity
        let service = NoiseEncryptionService(keychain: keychain)

        // Should have generated and saved keys
        #expect(service.getStaticPublicKeyData().count == 32)
        #expect(service.getSigningPublicKeyData().count == 32)

        // Keys should be persisted
        let noiseKeyResult = keychain.getIdentityKeyWithResult(forKey: "noiseStaticKey")
        switch noiseKeyResult {
        case .success:
            // Expected - key was saved
            break
        default:
            throw KeychainTestError("Expected noise key to be saved")
        }
    }

    @Test func noiseEncryptionService_loadsExistingIdentity() throws {
        let keychain = MockKeychain()

        // Create first service to generate identity
        let service1 = NoiseEncryptionService(keychain: keychain)
        let originalPublicKey = service1.getStaticPublicKeyData()
        let originalSigningKey = service1.getSigningPublicKeyData()

        // Create second service - should load same identity
        let service2 = NoiseEncryptionService(keychain: keychain)

        #expect(service2.getStaticPublicKeyData() == originalPublicKey)
        #expect(service2.getSigningPublicKeyData() == originalSigningKey)
    }

    @Test func noiseEncryptionService_handlesAccessDeniedGracefully() throws {
        let keychain = MockKeychain()
        keychain.simulatedReadError = .accessDenied

        // Service should still initialize with ephemeral key
        let service = NoiseEncryptionService(keychain: keychain)

        // Should have an identity (ephemeral)
        #expect(service.getStaticPublicKeyData().count == 32)
        #expect(service.getSigningPublicKeyData().count == 32)
    }

    @Test func noiseEncryptionService_handlesDeviceLockedGracefully() throws {
        let keychain = MockKeychain()
        keychain.simulatedReadError = .deviceLocked

        // Service should still initialize with ephemeral key
        let service = NoiseEncryptionService(keychain: keychain)

        // Should have an identity (ephemeral)
        #expect(service.getStaticPublicKeyData().count == 32)
    }
}

// Helper error type for tests
private struct KeychainTestError: Error, CustomStringConvertible {
    let message: String
    init(_ message: String) { self.message = message }
    var description: String { message }
}
