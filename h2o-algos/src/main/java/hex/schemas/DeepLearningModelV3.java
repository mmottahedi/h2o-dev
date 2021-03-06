package hex.schemas;

import hex.deeplearning.DeepLearningModel;
import water.Key;
import water.api.*;

public class DeepLearningModelV3 extends ModelSchema<DeepLearningModel, DeepLearningModelV3, DeepLearningModel.DeepLearningParameters, DeepLearningV3.DeepLearningParametersV3, DeepLearningModel.DeepLearningModelOutput, DeepLearningModelV3.DeepLearningModelOutputV3> {

  public static final class DeepLearningModelOutputV3 extends ModelOutputSchema<DeepLearningModel.DeepLearningModelOutput, DeepLearningModelOutputV3> {
    @API(help="Frame keys for weight matrices")
    KeyV3.FrameKeyV3[] weights;

    @API(help="Frame keys for bias vectors")
    KeyV3.FrameKeyV3[] biases;

    @API(help="Variable Importances", direction=API.Direction.OUTPUT)
    TwoDimTableBase variable_importances;
  }

  // TODO: I think we can implement the following two in ModelSchema, using reflection on the type parameters.
  public DeepLearningV3.DeepLearningParametersV3 createParametersSchema() { return new DeepLearningV3.DeepLearningParametersV3(); }
  public DeepLearningModelOutputV3 createOutputSchema() { return new DeepLearningModelOutputV3(); }

  //==========================
  // Custom adapters go here

  // Version&Schema-specific filling into the impl
  @Override public DeepLearningModel createImpl() {
    DeepLearningModel.DeepLearningParameters parms = parameters.createImpl();
    return new DeepLearningModel(Key.make() /*dest*/, parms, new DeepLearningModel.DeepLearningModelOutput(null), null, null);
  }
}
