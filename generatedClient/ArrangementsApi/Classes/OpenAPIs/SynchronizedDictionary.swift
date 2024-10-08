// SynchronizedDictionary.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

internal struct SynchronizedDictionary<K: Hashable, V> {

    private var dictionary = [K: V]()
    private let queue = DispatchQueue(
        label: "SynchronizedDictionary",
        qos: DispatchQoS.userInitiated,
        attributes: [DispatchQueue.Attributes.concurrent],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit,
        target: nil
    )

    internal subscript(key: K) -> V? {
        get {
            var value: V?

            queue.sync {
                value = self.dictionary[key]
            }

            return value
        }
        set {
            queue.sync(flags: DispatchWorkItemFlags.barrier) {
                self.dictionary[key] = newValue
            }
        }
    }
}