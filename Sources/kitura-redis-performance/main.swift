import Foundation
import Dispatch
import SwiftRedis

//require 'redis'
//
//N = 1_000_000
//
//start_time = Time.now
//
//redis = Redis.new
//redis.pipelined do
//N.times do |i|
//redis.set('foo', 'bar')
//end
//end
//
//end_time = Time.now
//
//elapsed_time = (end_time - start_time)
//puts "Elapsed time: #{elapsed_time}s"
//puts "Done"

let N: Int = 1000000
let start = Date()

let semaphore = DispatchSemaphore(value: 0)
let redis = Redis()
redis.connect(host: "localhost", port: 6379) { (redisError: NSError?) in
    guard redisError == nil else { return }
    
    for _ in 0...1000 {
        let localSemaphore = DispatchSemaphore(value: 0)
        
        // Should split transactions to avoid stack overflow
        var transaction = redis.multi()
        for _ in 0...(N / 1000) {
            transaction = transaction.set("hoge", value: "foo")
        }
        transaction.exec { _ in
            localSemaphore.signal()
        }
        localSemaphore.wait()
    }
    semaphore.signal()
}
semaphore.wait()
let timeInterval = Date().timeIntervalSince(start)
let throughput = Double(N) / timeInterval
print("Elapsed time: \(timeInterval), throughput: \(throughput) commands/sec")
print("Done")
