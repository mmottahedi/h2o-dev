import sys
sys.path.insert(1, "../../../")
import h2o

def iris_nfolds_getModel(ip,port):
    # Connect to h2o
    h2o.init(ip,port)

    iris = h2o.import_frame(path=h2o.locate("smalldata/iris/iris.csv"))

    model = h2o.random_forest(y=iris[4], x=iris[0:4], ntrees=50, nfolds=5)
    model.show()

    model = h2o.getModel(model._key)
    model.show()

if __name__ == "__main__":
  h2o.run_test(sys.argv, iris_nfolds_getModel)
