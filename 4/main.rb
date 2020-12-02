puts (347312..805915)
       .to_a
       .filter { |password| (0...6).any? { |i| (password.to_s[i + 1] == password.to_s[i]) and (not(password.to_s[i] == password.to_s[i + 2] or password.to_s[i] == password.to_s[i - 1])) } }
       .filter { |password| password == password.to_s.split("").sort.join.to_i }
       .length
