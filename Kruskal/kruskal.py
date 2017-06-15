class Edge:

    def __init__(self, src_node_num, tag_node_num, weight):

        self.src_node_num = src_node_num

        self.tag_node_num = tag_node_num

        self.weight = weight

    def __str__(self):

        return "(src:%d, tag:%d, weight:%d)" % (self.src_node_num, self.tag_node_num, self.weight)


class Graph:

    def __init__(self):

        self.nodes = set()

        self.edges = []

    def add_node(self, node_num):

        if node_num not in self.nodes:

            self.nodes.add(node_num)

        else:

            print('Node is existed.')

    def add_edge(self, src_node_num, tag_node_num, weight):

        if src_node_num not in self.nodes or tag_node_num not in self.nodes:

            print("Node doesn't exist.")

        self.edges.append(Edge(src_node_num, tag_node_num, weight))

    def kruskal_minimal_tree(self):

        visited = {}

        ret_edges = []

        #sorted(self.vertexes, key = lambda a: a.weight)

        target_link_numbers = len(self.nodes) - 1

        if len(self.edges) < target_link_numbers:

            raise Exception('No enough vertexes to construct the tree')

        for sym in self.nodes:

            visited[sym] = sym                                                   # Use their own values to mark the set.

        self.edges.sort(key= lambda a: a.weight)

        edge_idx = 0

        while len(ret_edges) < target_link_numbers:

            set_mark1 = visited[self.edges[edge_idx].src_node_num]

            set_mark2 = visited[self.edges[edge_idx].tag_node_num]

            if set_mark1 != set_mark2:                                          # If they are in different set, means no loop. Add this edge.

                ret_edges.append(self.edges[edge_idx])

                for k, v in visited.items():                                    # Merge them to a set.

                    if v == set_mark2:

                        visited[k] = set_mark1

            edge_idx += 1

        return ret_edges


def testcase1():

    graph = Graph()

    graph.add_node(1)
    graph.add_node(2)
    graph.add_node(3)
    graph.add_node(4)
    graph.add_node(5)
    graph.add_node(6)
    graph.add_node(7)

    graph.add_edge(1, 2, 7)
    graph.add_edge(1, 4, 5)
    graph.add_edge(2, 3, 8)
    graph.add_edge(2, 4, 9)
    graph.add_edge(2, 5, 7)
    graph.add_edge(3, 5, 5)
    graph.add_edge(4, 5, 15)
    graph.add_edge(4, 6, 6)
    graph.add_edge(5, 6, 8)
    graph.add_edge(5, 7, 9)
    graph.add_edge(6, 7, 11)

    edges = graph.kruskal_minimal_tree()

    for edge in edges:

        print(edge)



def testcase2():

    graph = Graph()

    graph.add_node(1)
    graph.add_node(2)
    graph.add_node(3)
    graph.add_node(4)
    graph.add_node(5)
    graph.add_node(6)
    graph.add_node(7)

    graph.add_edge(1, 2, 20)
    graph.add_edge(1, 6, 23)
    graph.add_edge(1, 7, 1)
    graph.add_edge(2, 3, 15)
    graph.add_edge(2, 7, 4)
    graph.add_edge(3, 7, 9)
    graph.add_edge(3, 4, 3)
    graph.add_edge(4, 7, 16)
    graph.add_edge(4, 5, 17)
    graph.add_edge(5, 7, 25)
    graph.add_edge(5, 6, 20)
    graph.add_edge(6, 7, 16)

    edges = graph.kruskal_minimal_tree()

    for edge in edges:

        print(edge)


if __name__ == '__main__':

    testcase1()

    # testcase2()