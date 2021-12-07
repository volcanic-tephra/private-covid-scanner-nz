import 'package:convert/convert.dart' as convert;
import 'package:base32/base32.dart';
import 'package:cbor/cbor.dart';

class CovidPassportSubject {
  final String givenName;
  final String familyName;
  final DateTime dob;

  CovidPassportSubject(this.givenName, this.familyName, this.dob);

  factory CovidPassportSubject.from(Map<dynamic, dynamic> fields) {
    return CovidPassportSubject(fields['givenName'],
          fields['familyName'],
          DateTime.parse(fields['dob']));
  }

  String toString() {
    final body = {
      'givenName': givenName,
      'familyName': familyName,
      'dob': dob
    };

    return body.toString();
  }
}

class VerifiableCredential<T> {
  final List<String> context;
  final String version;
  final List<String> type;
  final T credentialSubject;

  VerifiableCredential(this.context, this.version, this.type, this.credentialSubject);

  @override
  String toString() {
    final body = {
      '@context': context,
      'version': version,
      'type': type,
      'credentialSubject': credentialSubject
    };

    return body.toString();
  }
}

/// Cose signed identity (see https://datatracker.ietf.org/doc/html/rfc8152)
class Cose<T> {
  final String iss;
  final int nbf;
  final int exp;
  final String jti;
  final VerifiableCredential<T> vc;

  Cose(this.iss, this.nbf, this.exp, this.jti, this.vc);

  DateTime get notBefore {
    return DateTime.fromMillisecondsSinceEpoch(this.nbf * 1000);
  }

  DateTime get expiry {
    return DateTime.fromMillisecondsSinceEpoch(this.exp * 1000);
  }
  
  String get id {
    return jti.substring(9);
  }

  factory Cose.from(String raw) {
    final decoded = base32.decode(raw);
    final cbor = Cbor();
    cbor.decodeFromList(decoded);
    final payload = cbor.getDecodedData()?[0];
    if (payload != null) {
      // Body
      cbor.clearEncodedOutput();
      cbor.clearDecodeStack();
      cbor.decodeFromList(payload[2]);
      var content = cbor.getDecodedData()?[0];

      if (content != null) {
        final iss = content[1] as String;
        final nbf = content[5] as int;
        final exp = content[4] as int;
        final vc = content['vc'];
        final context = VerifiableCredential<T>(
            vc['@context'].cast<String>() as List<String>,
            vc['version'],
            vc['type'].cast<String>() as List<String>,
            CovidPassportSubject.from(vc['credentialSubject']) as T);
        final jti = convert.hex.encoder.convert(content[7]);

        return Cose(iss,
            nbf,
            exp,
            _formatJti(jti),
            context
        );
      }
    }

    throw Exception('Invalid Cose structure');
  }

  static String _formatJti(String raw) {
    return 'urn:uuid:'
        + raw.substring(0, 8)
        + '-'
        + raw.substring(8, 12)
        + '-'
        + raw.substring(12, 16)
        + '-'
        + raw.substring(16, 20)
        + '-'
        + raw.substring(20);
  }

  @override
  String toString() {
    final body = {
      'iss': iss,
      'nbf': nbf,
      'exp': exp,
      'jti': jti,
      'vc': vc,
    };

    return body.toString();
  }
}
