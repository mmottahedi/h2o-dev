import sys
sys.path.insert(1, "../../")
import h2o

def pub_445_long_request_uri(ip,port):
    # Connect to h2o
    h2o.init(ip,port)

    mnistTrain = h2o.import_frame(path=h2o.locate("bigdata/laptop/mnist/train.csv.gz"))
    mnistTest = h2o.import_frame(path=h2o.locate("bigdata/laptop/mnist/train.csv.gz"))

    mnistTrain[784]._name = "label"
    mnistTest[784]._name = "label"

    mnistModel = h2o.gbm(x=mnistTrain.drop("label"), y=mnistTrain["label"], validation_x=mnistTest.drop("label"), validation_y=mnistTest["label"], ntrees=100, max_depth=10)

if __name__ == "__main__":
    h2o.run_test(sys.argv, pub_445_long_request_uri)
