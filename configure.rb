require 'rbconfig'

VAR_PATTERN = /\$\((?<name>[a-z_]+)\)/i

REPLACEMENTS = Hash[RbConfig::MAKEFILE_CONFIG.map do |key, value|
  ["$(#{key})", value]
end]

def expand_path(path)
  if path =~ VAR_PATTERN
    new_path = path.gsub(VAR_PATTERN, REPLACEMENTS)
    expand_path(new_path)
  else
    path
  end
end

puts "-L#{expand_path('$(libdir)')}"
puts "-I#{expand_path('$(rubyarchhdrdir)')}"
puts "-I#{expand_path('$(rubyhdrdir)')}"
puts "-l#{expand_path('$(RUBY_SO_NAME)')}"
