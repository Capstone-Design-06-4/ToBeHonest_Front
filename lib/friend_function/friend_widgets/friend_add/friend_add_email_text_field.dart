import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  final String selectedDomain;
  final List<String> domainList;
  final String errorText;
  final Function(String?) onDomainChanged;

  EmailTextField({
    Key? key,
    required this.emailController,
    required this.selectedDomain,
    required this.domainList,
    required this.errorText,
    required this.onDomainChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: '이메일 입력',
        border: OutlineInputBorder(),
        hintText: 'yourname@example.com',
        suffixIcon: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedDomain,
            items: domainList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value == '직접 입력' ? value : '@' + value),
              );
            }).toList(),
            onChanged: onDomainChanged,
          ),
        ),
        errorText: errorText.isNotEmpty ? errorText : null,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
