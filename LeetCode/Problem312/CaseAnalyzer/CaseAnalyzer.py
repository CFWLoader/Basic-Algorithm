from graphviz import Digraph

class CaseNode:

	def __init__(self, nodeNumber, datas, parentSum):

		self.nodeNumber = nodeNumber

		self.datas = datas

		self.coins = []

		self.parentSum = parentSum

	def generateCoinsByRules(self):

		arrayLength = len(self.datas)

		for idx in range(0, arrayLength):

			left = idx - 1; right = idx + 1

			if left < 0:
				left = 1
			else:
				left = self.datas[left]

			if right >= arrayLength:
				right = 1
			else:
				right = self.datas[right]

			coinSum = left * self.datas[idx] * right

			self.coins.append(coinSum)

	def __str__(self):

		return self.datas.__str__() + '\n' + self.coins.__str__() + '\nCoin Sum: %d' % self.parentSum


class CaseAnalyzer:

	def __init__(self, originData, filePath = './case-tree.gv'):

		self.datas = originData

		self.nodeNumberCounter = 1

		self.filePath = filePath

	def generateGraph(self):

		graph = Digraph(comment = 'Case Tress')

		rootNode = CaseNode(self.nodeNumberCounter, [3, 1, 5, 8], 0)

		generateGraph(graph, rootNode)

		graph.render(self.filePath)

	def generateGraph(self, graph, caseNode):

		nodeNumberStr = '%d' % caseNode.nodeNumber

		graph.node(nodeNumberStr, caseNode.__str__())




if __name__ == '__main__':

	# graph = Digraph(comment = 'Posibilities')

	# generateGraph([3, 1, 5, 8], graph, None)			# [3, 1, 5, 8]

	caseNode = CaseNode(1, [3, 1, 5, 8], 0)

	caseNode.generateCoinsByRules()

	print caseNode