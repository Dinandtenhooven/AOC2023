

def getKey(x, y)
    return "%d-%d" % [x, y]
end 

def withSas(startChar)
    h = {}
    arr = []
    dots = {}

    line_num = 0
    File.open('example.txt').each do |line|
        char_num = 0
        
        line.each_char do |ch|
            if ch == 'S'
                position = { 
                    'x' => char_num, 
                    'y' => line_num,
                    'char' => startChar,
                    'count' => 0 
                }
                h[getKey(char_num, line_num)] = position
                arr << position
            elsif ch != '.'
                position = { 
                    'x' => char_num, 
                    'y' => line_num,
                    'char' => startChar,
                    'count' => 0 
                }
                dots[getKey(char_num, line_num)] = position
            elsif ch != "\n"
                position = { 
                    'x' => char_num, 
                    'y' => line_num,
                    'char' => ch,
                    'count' => 1000000000 
                }
                h[getKey(char_num, line_num)] = position
            end

            char_num += 1
        end

        line_num += 1
    end

    # h.each do |key, elem|
    #     puts elem
    # end
    puts "-------------"

    while arr.count > 0
        elem = arr[0]
        # puts elem
        arr.shift
        
        x = elem['x']
        y = elem['y']
        count = elem['count']
        ch = elem['char']

        dirs = []
        neighborDots = []

        case ch
        when 'S'
            dirs = [
                { 'x' => 1, 'y' => 0 },
                { 'x' => -1, 'y' => 0 },
                { 'x' => 0, 'y' => 1 },
                { 'x' => 0, 'y' => -1 }
            ]
        when '|'
            dirs = [{ 'x' => 0, 'y' => 1 }, { 'x' => 0, 'y' => -1 }]
        when '-'
            dirs = [{ 'x' => -1, 'y' => 0 }, { 'x' => 1, 'y' => 0 }]
        when 'L'
            dirs = [{ 'x' => 0, 'y' => -1 }, { 'x' => 1, 'y' => 0 }]
        when 'J'
            dirs = [{ 'x' => 0, 'y' => -1 }, { 'x' => -1, 'y' => 0 }]
        when '7'
            dirs = [{ 'x' => 0, 'y' => 1 }, { 'x' => -1, 'y' => 0 }]
        when 'F'
            dirs = [{ 'x' => 0, 'y' => 1 }, { 'x' => 1, 'y' => 0 }]
        else
            puts "Nothing"
        end

        dirs.each do |dir| 
            nx = x + dir['x']
            ny = y + dir['y']
            key = getKey(nx, ny)
            # puts key

            if h.key?(key)
                target = h[key];
                if target['count'] > (count+1) 
                    arr << { 
                        'x' => nx, 
                        'y' => ny,
                        'char' => target['char'],
                        'count' => count+1 
                    }
                    h[key] = { 
                        'x' => nx, 
                        'y' => ny,
                        'char' => target['char'],
                        'count' => count+1 
                    }
                end
            end
        end

        dirs.each do |dir| 
            nx = x - dir['x']
            ny = y - dir['y']
            key = getKey(nx, ny)
            # puts key

            if dots.key?(key)

            end
        end
        
    end

    puts "-------------"
    minimum = 0;
    h.each do |key, elem|
        # puts elem
        if minimum < elem['count'] && elem['count'] != 1000000000
            minimum = elem['count']
        end
    end
    puts "-------------"
    puts minimum    
    return minimum
end

minimums = [
    withSas('J')
]

puts "-------------"
puts minValue    
