class Vertex:

    def __init__(self, src_node_num, tag_node_num, weight):

        self.src_node_num = src_node_num

        self.tag_node_num = tag_node_num

        self.weight = weight

    def __str__(self):

        return "(src:%d, tag:%d, weight:%d)" % (self.src_node_num, self.tag_node_num, self.weight)


class Graph:

    def __init__(self):

        self.nodes = set()

        self.vertexes = []

    def add_node(self, node_num):

        if node_num not in self.nodes:

            self.nodes.add(node_num)

        else:

            print('Node is existed.')

    def add_vertex(self, src_node_num, tag_node_num, weight):

        if src_node_num not in self.nodes or tag_node_num not in self.nodes:

            print("Node doesn't exist.")

        self.vertexes.append(Vertex(src_node_num, tag_node_num, weight))

    def kruskal_minimal_tree(self):

        visited = set()

        ret_vertexes = []

        #sorted(self.vertexes, key = lambda a: a.weight)

        self.vertexes.sort(key=lambda v:v.weight)

        for vertex in self.vertexes:

            if vertex.src_node_num in visited and vertex.tag_node_num in visited:

                continue

            if vertex.src_node_num not in visited: visited.add(vertex.src_node_num)

            if vertex.tag_node_num not in visited: visited.add(vertex.tag_node_num)

            ret_vertexes.append(vertex)

        return ret_vertexes


if __name__ == '__main__':

    graph = Graph()

    graph.add_node(1)
    graph.add_node(2)
    graph.add_node(3)
    graph.add_node(4)
    graph.add_node(5)
    graph.add_node(6)
    graph.add_node(7)

    graph.add_vertex(1, 2, 7)
    graph.add_vertex(1, 4, 5)
    graph.add_vertex(2, 3, 8)
    graph.add_vertex(2, 4, 9)
    graph.add_vertex(2, 5, 7)
    graph.add_vertex(3, 5, 5)
    graph.add_vertex(4, 5, 15)
    graph.add_vertex(4, 6, 6)
    graph.add_vertex(5, 6, 8)
    graph.add_vertex(5, 7, 9)
    graph.add_vertex(6, 7, 11)

    edges = graph.kruskal_minimal_tree()

    for edge in edges:

        print(edge)

