import Foundation
import Dispatch
import PerfectRedis

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

let identifier = RedisClientIdentifier(withHost: "127.0.0.1", port: 6379)

let semaphore = DispatchSemaphore(value: 0)
RedisClient.getClient(withIdentifier: identifier) { getClient in
    do {
        let client: RedisClient = try getClient()
        for _ in 0...N {
            let localSemaphore = DispatchSemaphore(value: 0)
            client.set(key: "foo", value: .string("bar")) { _ in
                localSemaphore.signal()
            }
            localSemaphore.wait()
        }
        semaphore.signal()
    }
    catch {
    }
}
semaphore.wait()
let timeInterval = Date().timeIntervalSince(start)
let throughput = Double(N) / timeInterval
print("Elapsed time: \(timeInterval), throughput: \(throughput) commands/sec")
print("Done")
