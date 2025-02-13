/* Copyright 2020 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

include "mlir/Pass/PassBase.td"

def TosaLegalizeTFPass : FunctionPass<"tosa-legalize-tf"> {
  let summary = "Legalize from TensorFlow to TOSA";
  let constructor = "createLegalizeTFPass()";
  let dependentDialects = ["TosaDialect", "quant::QuantizationDialect"];
}

def TosaLegalizeTFLPass : FunctionPass<"tosa-legalize-tfl"> {
  let summary = "Legalize from TensorFlow Lite to TOSA. Options allow selective disabling/enabling of rewrites";
  let constructor = "createLegalizeTFLPass()";

  let dependentDialects = ["TosaDialect"];
  let options = [
    ListOption<"disabled_patterns_", "disable-patterns", "std::string",
               "Labels of patterns that should be filtered out during application",
               "llvm::cl::MiscFlags::CommaSeparated">,
    ListOption<"enabled_patterns_", "enable-patterns", "std::string",
               "Labels of patterns that should be used during application, all other patterns are filtered out",
               "llvm::cl::MiscFlags::CommaSeparated">,
  ];
}

def TosaLegalizeTFTFLPass : FunctionPass<"tosa-legalize-tf-tfl"> {
  let summary = "Legalize from TensorFlow / TensorFlow Lite to TOSA";
  let constructor = "createLegalizeTFTFLPass()";
  let dependentDialects = ["TosaDialect"];
}

def TosaFusebiasTFPass : FunctionPass<"tosa-fuse-bias-tf"> {
  let summary = "Fuse tf.Op + tf.BiasAdd and legalized to TOSA";
  let constructor = "createFuseBiasTFPass()";
  let dependentDialects = ["TosaDialect"];
}

def TosaConvertTFLUint8Pass : FunctionPass<"tosa-convert-tfl-uint8"> {
  let summary = "Convert uint8 graph to int8 graph";
  let constructor = "createConvertTFLUint8Pass()";
  let dependentDialects = ["TosaDialect"];
}

def TosaStripQuantTypesPass : FunctionPass<"tosa-strip-quant-types"> {
  let summary = "Convert all quant types to their storage type.";
  let constructor = "createStripQuantTypesPass()";
  let dependentDialects = ["TosaDialect"];
}
