import Foundation
import Redis

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

let redis = try! Redis.TCPClient(hostname: "127.0.0.1", port: 6379)
let pipeline = redis.makePipeline()

for _ in 1...N {
    try! pipeline.enqueue(.set, ["foo", "bar"])
}

_ = try! pipeline.execute()

let timeInterval = Date().timeIntervalSince(start)
let throughput = Double(N) / timeInterval
print("Elapsed time: \(timeInterval), throughput: \(throughput) commands/sec")
print("Done")
