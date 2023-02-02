# Here is the implementation of the diff and patch tools in Ruby:

# diff.rb
# Usage: ruby diff.rb file1 file2

file1 = ARGV[0]
file2 = ARGV[1]

def diff(file1, file2)
  lines1 = File.readlines(file1)
  lines2 = File.readlines(file2)
  diff = []

  lines1.each_with_index do |line1, i|
    line2 = lines2[i]
    if line1 != line2
      diff << [i, line1, line2]
    end
  end

  return diff
end

diff_output = diff(file1, file2)
diff_output.each do |d|
  puts "#{d[0]}c#{d[0]} #{d[2].chomp}\n< #{d[1].chomp}"
end

# patch.rb
# Usage: ruby patch.rb file diff_output

file = ARGV[0]
diff_output_file = ARGV[1]

def patch(file, diff_output_file)
  lines = File.readlines(file)
  diff_output = File.readlines(diff_output_file)

  diff_output.each do |d|
    index = d.split[0].to_i
    lines[index] = d.split[2..-1].join(" ") + "\n"
  end

  return lines.join
end

patched_file = patch(file, diff_output_file)
puts patched_file
