import 'package:bt_mobile/common/user.dart';
import 'package:bt_mobile/constants/strings.dart';
import 'package:bt_mobile/new_member/form/form_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../base/presenter.dart';
import 'new_member_model.dart';
import 'new_member_view.dart';

class NewMemberPresenter extends Presenter<NewMemberView, NewMemberModel> {
  NewMemberPresenter() {
    model = NewMemberModel();
    addFormModels();
  }

  User user = GetIt.I<User>();

  bool areUserFieldsValid() {
    return firstNameValidator(user.firstName) == null &&
        lastNameValidator(user.lastName) == null &&
        emailValidator(user.email) == null &&
        _isStudentIdTouched &&
        studentIdValidator('${user.studentId}') == null &&
        user.faculty != null &&
        user.year != null &&
        user.diet != null;
  }

  String firstNameValidator(String value) {
    if (value.isEmpty) {
      return S.newMemberFirstNameRequired;
    }
    return null;
  }

  String lastNameValidator(String value) {
    if (value.isEmpty) {
      return S.newMemberLastNameRequired;
    }
    return null;
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      return S.newMemberEmailRequired;
    } else {
      // https://stackoverflow.com/questions/16800540/validate-email-address-in-dart
      final bool isValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!isValid) {
        return 'Valid email address is required';
      }
    }
    return null;
  }

  String studentIdValidator(String value) {
    if (!_isStudentIdTouched) {
      // Only show validation error after it has been modified.
      _isStudentIdTouched = true;
    } else if (value.isEmpty) {
      return 'Student number is required';
    } else if (int.tryParse(value) == null || value.length != 8) {
      return 'Valid student number is required';
    }
    return null;
  }

  void addFormModels() {
    model.formModels = [
      DisclaimerModel(),
      TextFieldModel(
        labelText: S.newMemberFirstName,
        validator: firstNameValidator,
        onChanged: (String newValue) {
          user.firstName = newValue;
          updateView();
        },
        initialValue: user.firstName,
      ),
      TextFieldModel(
        labelText: S.newMemberLastName,
        validator: lastNameValidator,
        onChanged: (String newValue) {
          user.lastName = newValue;
          updateView();
        },
        initialValue: user.lastName,
      ),
      TextFieldModel(
        labelText: S.newMemberEmail,
        validator: emailValidator,
        keyboardType: TextInputType.emailAddress,
        onChanged: (String newValue) {
          user.email = newValue;
          updateView();
        },
        initialValue: user.email,
        enabled: false,
      ),
      TextFieldModel(
        labelText: S.newMemberStudentId,
        validator: studentIdValidator,
        keyboardType: TextInputType.number,
        onChanged: (String newValue) {
          final int value = int.tryParse(newValue) ?? -1;
          user.studentId = value;
          updateView();
        },
      ),
      TextFieldModel(
        labelText: S.newMemberMembershipCode,
        onChanged: (String newValue) {
          user.inviteCode = newValue;
          updateView();
        },
        isRequired: false,
      ),
      RadioFieldModel(
        labelText: S.newMemberFaculty,
        values: [
          S.newMemberFacultyArts,
          S.newMemberFacultyCommerce,
          S.newMemberFacultyScience,
          S.newMemberFacultyEngineering,
          S.newMemberFacultyKinesiology,
          S.newMemberFacultyLfs,
          S.newMemberFacultyForestry,
        ],
        onChanged: (newValue) {
          user.faculty = newValue;
          updateView();
        },
        hasOther: true,
        onOtherSaved: (value) {
          user.faculty = value;
          updateView();
        },
      ),
      RadioFieldModel(
        labelText: S.newMemberYear,
        values: [
          S.newMember1Year,
          S.newMember2Year,
          S.newMember3Year,
          S.newMember4Year,
          S.newMember5PlusYear,
        ],
        onChanged: (newValue) {
          user.year = newValue;
          updateView();
        },
      ),
      RadioFieldModel(
        labelText: S.newMemberDiet,
        values: [
          S.newMemberDietNone,
          S.newMemberDietVegetarian,
          S.newMemberDietVegan,
          S.newMemberDietGlutenFree,
        ],
        onChanged: (newValue) {
          user.diet = newValue;
          updateView();
        },
        hasOther: true,
        onOtherSaved: (newValue) {
          user.diet = newValue;
          updateView();
        },
      ),
      RadioFieldModel(
        labelText: S.newMemberGender,
        values: [
          S.newMemberGenderMale,
          S.newMemberGenderFemale,
          S.newMemberGenderOther,
        ],
        onChanged: (newValue) {
          user.gender = newValue;
          updateView();
        },
        isRequired: false,
      ),
      RadioFieldModel(
        labelText: S.newMemberHeardFrom,
        values: [
          S.newMemberHeardFromFacebook,
          S.newMemberHeardFromBoothing,
          S.newMemberHeardFromFriends,
          S.newMemberHeardFromBizTechNewsletter,
          S.newMemberHeardFromFacultyNewsletter,
        ],
        onChanged: (newValue) {
          user.heardFrom = newValue;
          updateView();
        },
        hasOther: true,
        onOtherSaved: (value) {
          user.heardFrom = value;
          updateView();
        },
        isRequired: false,
      ),
      SubmitButtonModel(
        onPressed: () {
          updateView();
        },
        isEnabled: areUserFieldsValid,
      ),
    ];
  }

  bool _isStudentIdTouched = false;
}
