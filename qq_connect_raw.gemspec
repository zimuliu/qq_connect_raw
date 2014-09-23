# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'qq_connect_raw'

Gem::Specification.new do |s|
  s.summary = "QQ Connect API library"
  s.name = "QQConnectRaw"
  s.author = "Zimu Liu"
  s.email =  "zimu.liu@gmail.com"
  s.homepage = "https://github.com/zimuliu/qq_connect_raw"
  s.license = ""
  s.version = QQConnectRaw::VERSION
  s.files = Dir["examples/*.rb"] + Dir["test/*.rb"] + Dir["lib/**/*.rb"] #+ %w{qq-connect_rdoc.rb LICENSE README.rdoc rakefile}
  s.add_runtime_dependency 'oauth2', '~> 1.0'
end

