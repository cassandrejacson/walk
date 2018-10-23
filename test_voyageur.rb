# c1 = Coordinates.new(1, 8)
# c2 = Coordinates.new(2, 2)
# c3 = Coordinates.new(4, 5)
# c4 = Coordinates.new(6, 7)
# c5 = Coordinates.new(8, 4)
# c6 = Coordinates.new(9, 1)
MINITER = 20
x = []
y = []
30.times do
  x << rand(100.0)
  y << rand(100.0)
end
p x
p y

def longueur (x,y, ordre)
    i = ordre[-1]
    x0 = x[i]
    y0 = y[i]
    d = 0
    for o in ordre
        x1 = x[o]
        y1 = y[o]
        d += (x0 - x1)**2 + (y0 - y1)**2
        x0 = x1
        y0 = y1
    end
    return d
end

ordre = (0..x.length - 1).to_a
puts("longueur initiale" , longueur(x, y, ordre))

# def permutation(x,y,ordre)
#     d  = longueur(x,y,ordre)
#     d0 = d+1
#     it = 1
#     while d < d0
#         it += 1
#         puts("iteration",it, "d=",d)
#         d0 = d
#         for i in 1..(ordre.length-1)
#             for j in i+2..(ordre.length)
#                 r = Array(ordre[i...j])
#                 r = r.reverse
#                 ordre2 = ordre[0...i] + r + ordre[j..-1]
#                 t = longueur(x,y,ordre2)
#                 if t < d
#                     d = t
#                     ordre = ordre2
#                 end
#             end
#         end
#     end
#   return ordre
# end

def permutation_rnd(x,y,ordre,miniter)
    d  = longueur(x,y,ordre)
    d0 = d+1
    it = 1
    while d < d0 or it < miniter
        it += 1
        d0 = d
        for i in 1...(ordre.length-1)
            for j in i+2...(ordre.length + 1)
                k = rand(1..(ordre.length-1))
                l = rand(k+1..ordre.length)
                r = Array(ordre[k...l])
                r = r.reverse
                ordre2 = ordre[0...k] + r + ordre[l..-1]
                t = longueur(x,y,ordre2)
                if t < d
                    d = t
                    ordre = ordre2
                end
            end
        end
    end
  return ordre
end

def n_permutation(x,y, miniter)
    ordre = (0...(x.length)).to_a
    bordre = Array(ordre)
    d0 = longueur(x,y,ordre)
    for i in (0...MINITER)
        puts("iteration",i, "d=",d0)
        ordre = ordre.shuffle
        ordre = permutation_rnd(x, y,ordre, MINITER)
        d = longueur(x,y,ordre)
        if d < d0
            d0 = d
            bordre = Array(ordre)
        end
    end
    return bordre
end

ordre = n_permutation(x,y, MINITER)

puts "longueur min", longueur(x,y,ordre)
# xo = [ x[o] for o in ordre + [ordre[0]]]
# yo = [ y[o] for o in ordre + [ordre[0]]]
xo = []
yo = []
for o in ordre +[ordre[0]]
  xo << x[o]
  yo << y[o]
end

p xo
p yo


