require 'set'

def garden_no_adj(n, paths)
    adj_list = {}
    paths.each do |path|
        adj_list[path[0]] = Set.new unless adj_list.include?(path[0])
        adj_list[path[1]] = Set.new unless adj_list.include?(path[1])
        adj_list[path[0]].add(path[1])
        adj_list[path[1]].add(path[0])
    end
    bfs(adj_list, n, paths)
end

def bfs(adj_list, n, paths)
    visited = Set.new
    answer = Array.new(n,0)
    
    q = [1]
    (1..n).each do |seed|
        if(!visited.include?(seed))
            q.insert(0, seed)
        end
        while(q.length > 0)
            v = q.pop
            visited.add(v)
            
            answer[v-1] = color(adj_list[v], answer)

            if(adj_list.include?(v))
                nbrs = adj_list[v]
                nbrs.each do |nbr|
                    if(!visited.include?(nbr))
                        q.insert(0,nbr)
                    end
                end
            end
        end
    end
    answer
end

def color(nbrs, answer)
    colors = Array.new(5, 0)
    if !nbrs.nil?
        nbrs.each do |nbr|
            colors[answer[nbr-1]] = 1 if answer[nbr-1] > 0
        end
    end
    
    (1..4).each do |c|
        if(colors[c] == 0)
            return c
        end
    end
end
p garden_no_adj(3, [[1,2],[2,3],[3,1]])
p garden_no_adj(4, [[1,2],[3,4]])
p garden_no_adj(4, [[1,2],[2,3],[3,4],[4,1],[1,3],[2,4]])
p garden_no_adj(1, [])