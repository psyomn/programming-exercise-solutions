#!/usr/bin/ruby
ARGV[0].to_i.times{puts ([33..126] * ARGV[1].to_i).map{|chr| rand(chr).chr}.join('')}
