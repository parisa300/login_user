
class VerifyResponse {
  final bool created;
  final String accessToken;
  final String refreshToken;

  VerifyResponse({
    required this.created,
    required this.accessToken,
    required this.refreshToken,
  });
}