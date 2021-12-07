import 'package:test/test.dart';
import 'package:covid_barcode/src/models/covid_passport_barcode.dart';

void main() {
  final example = 'NZCP:/1/2KCEVIQEIVVWK6JNGEASNICZAEP2KALYDZSGSZB2O5SWEOTOPJRXALTDN53GSZBRHEXGQZLBNR2GQLTOPICRUYMBTIFAIGTUKBAAUYTWMOSGQQDDN5XHIZLYOSBHQJTIOR2HA4Z2F4XXO53XFZ3TGLTPOJTS6MRQGE4C6Y3SMVSGK3TUNFQWY4ZPOYYXQKTIOR2HA4Z2F4XW46TDOAXGG33WNFSDCOJONBSWC3DUNAXG46RPMNXW45DFPB2HGL3WGFTXMZLSONUW63TFGEXDALRQMR2HS4DFQJ2FMZLSNFTGSYLCNRSUG4TFMRSW45DJMFWG6UDVMJWGSY2DN53GSZCQMFZXG4LDOJSWIZLOORUWC3CTOVRGUZLDOSRWSZ3JOZSW4TTBNVSWISTBMNVWUZTBNVUWY6KOMFWWKZ2TOBQXE4TPO5RWI33CNIYTSNRQFUYDILJRGYDVAYFE6VGU4MCDGK7DHLLYWHVPUS2YIDJOA6Y524TD3AZRM263WTY2BE4DPKIF27WKF3UDNNVSVWRDYIYVJ65IRJJJ6Z25M2DO4YZLBHWFQGVQR5ZLIWEQJOZTS3IQ7JTNCFDX';

  group('Cose decoding', ()
  {
    test('Decodes example Cose token fields', () {
      final barcode = CovidPassportBarcode.from(example);
      expect(barcode.cose.iss, 'did:web:nzcp.covid19.health.nz');
      expect(barcode.cose.jti, 'urn:uuid:60a4f54d-4e30-4332-be33-ad78b1eafa4b');
      expect(barcode.cose.vc.credentialSubject.givenName, 'Jack');
      expect(barcode.cose.vc.credentialSubject.familyName, 'Sparrow');
    });

    test('Throws an error if incorrect url', () {
      expect(() => CovidPassportBarcode.from('CP:/1/ABC'), throwsException);
    });

    test('Throws an error version is not numeric', () {
      expect(() => CovidPassportBarcode.from('NZCP:/X/111'), throwsException);
    });

    test('Throws an error body not base32', () {
      expect(() => CovidPassportBarcode.from('NZCP:/1/111'), throwsException);
    });
  });
}