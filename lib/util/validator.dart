enum ValidatorType { REQUIRED, MINMAX, REGEX, NO_VALIDATOR }

class AllValidators {
  final Map<String?, Validators> allValidatorsInstance = {};

  AllValidators();

  Validators getValidatorInstance(
      String? value, List<ValidatorProps>? validators, String? key) {
    return allValidatorsInstance.putIfAbsent(
        key, () => Validators(value, validators));
  }

  String? validatorMethod(
      String? value, List<ValidatorProps>? validators, String? key) {
    final currentValidatorInstance =
        getValidatorInstance(value, validators, key);
    currentValidatorInstance.setValue(value);

    for (var validate in currentValidatorInstance.getValidatorResult()) {
      final result = validate();
      if (result != null) {
        return result;
      }
    }

    return null;
  }
}

class ValidatorProps {
  ValidatorType type = ValidatorType.NO_VALIDATOR;
  int? min;
  int? max;
  String? regexPattern;

  ValidatorProps(this.type, [this.min, this.max, this.regexPattern]);
}

class Validators {
  String? value = '';
  bool isSetuped = false;
  List<ValidatorProps>? validators = [];
  List<String? Function()> validatorResult = [];

  Validators(this.value, this.validators) {
    if (!isSetuped) {
      setupFormValidators();
    }
  }

  List<String? Function()> getValidatorResult() {
    return validatorResult;
  }

  void setValue(String? newValue) {
    value = newValue;
  }

  void setIsSetuped(bool newValue) {
    isSetuped = newValue;
  }

  void setupFormValidators() {
    if (validators == null) {
      return;
    }

    for (var validateSetting in validators!) {
      final validatorType = validateSetting.type;
      final min = validateSetting.min;
      final max = validateSetting.max;

      if (validatorType == ValidatorType.REQUIRED) {
        validatorResult.add(requiredValidator);
      } else if (validatorType == ValidatorType.MINMAX) {
        validatorResult.add(() => minMaxLengthValidator(min, max));
      } else if (validatorType == ValidatorType.REGEX) {
        validatorResult.add(() => minMaxLengthValidator(min, max));
      }
    }

    setIsSetuped(true);
  }

  String? requiredValidator() {
    if (value == null || value!.isEmpty) {
      return "EMPTRY";
    }

    return null;
  }

  String? minMaxLengthValidator(int? minLength, int? maxLength) {
    if (minLength == null || maxLength == null) {
      return null;
    }

    if (value != null && value!.length < minLength) {
      return "Min char $minLength characters required";
    }

    if (value != null && value!.length > maxLength) {
      return "Max char $maxLength characters required";
    }

    return null;
  }
}
