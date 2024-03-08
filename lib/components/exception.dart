class ExceptionAuth implements Exception {
  static const Map<String, String> error = {
    'EMAIL_EXISTS': 'O e-mail já está cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Login inválido.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado, tente novamente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha inválida.',
    'USER_DISABLED': 'Acesso inválido.',
    'INVALID_EMAIL' :  'Email inválido',
    'INVALID_LOGIN_CREDENTIALS' :  'E-mail e/ou Senha estão incorretos.',
    'WEAK_PASSWORD : Password should be at least 6 characters' :  'Senha deve ter pelo menos 6 caracteres',
    'MISSING_PASSWORD' :  'Informe a senha de acesso.',
    'MISSING_EMAIL' :  'Informe o e-mail de acesso.',
    
  };
  final String key;
  ExceptionAuth(this.key);

  String toString() {
    return error[key]??'Ocorreu um erro inesperado.';
  }
}
