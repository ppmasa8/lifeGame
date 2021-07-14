require 'pp'

def cls
  print "\033[2J"
end

def pos(x, y)
  print "\033[#{y+1};#{x+1}H"
end

def init_table(size_x, size_y)
  Array.new(size_y) do 
    Array.new(size_x) do
      (rand * 1.5).to_i
    end
  end
end

def round(table)
  size_x, size_y = table.first.size, table.size
  Array.new(size_y) do |y|
    Array.new(size_x) do |x|
      alives = 0
      -1.upto(1) do |dy|
        -1.upto(1) do |dx|
          next if dx == 0 && dy == 0
          px, py = dx + x, dy + y
          next unless 0 <= px && px < size_x
          next unless 0 <= py && py < size_y

          alives += table[py][px]
        end
      end

      case alives
      when 3
        1
      when 2
        table[y][x]
      else
        0
      end
    end
  end
end

def view(table)
  pos(0, 0)
  table.each do |line|
    line.each do |ceil|
      print "*" if ceil == 1
      print " " unless ceil == 1
    end
    puts
  end
end

size_x = (ARGV.shift || 80).to_i
size_y = (ARGV.shift || 24).to_i
table = init_table(size_x, size_y)
cls

loop do 
  table = view(round(table))
end
