require 'benchmark'
Benchmark.bm do |b|
  b.report do
    tries = 1000
    tries.times do |i|
      puts "#{i} of #{tries}" if (i % 10) == 0
      `curl http://localhost:3000/homepage 2>&1 > /dev/null`
    end
  end
end

