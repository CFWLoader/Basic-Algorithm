__author__ = 'CFWLoader'

def load_employee_data(path):

    src_data = open(path, 'r')

    data_collection = []

    for line in src_data:

        record = line.split(',')

        trans_rec = {}

        trans_rec['department'] = record[0]
        trans_rec['status'] = record[1]
        trans_rec['min age'] = int(record[2])
        trans_rec['max age'] = int(record[3])
        trans_rec['min salary'] = int(record[4])
        trans_rec['max salary'] = int(record[5])
        trans_rec['count'] = int(record[6])

        data_collection.append(trans_rec)

    src_data.close()

    return data_collection


def generate_decision_tree(data_coll):

    pass


if __name__ == '__main__':

    data_collection = load_employee_data('./employees.data')

    for record in data_collection:

        for key, val in record.items():

            print('(', key, ':', val, ')', sep='', end=' ')

        print()