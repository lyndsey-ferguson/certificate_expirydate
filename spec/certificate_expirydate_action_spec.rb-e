require 'fastlane'

describe Fastlane do
  describe Fastlane::FastFile do
    describe "CertificateExpirydateAction" do
      context "WHEN calling action with valid parameters" do
        before do
          allow(Fastlane::Actions::CertificateExpirydateAction).to receive(:sh).with(%r{openssl pkcs12 -in .*\/test_certificate.p12 -out .* -nodes -password pass:.*}).and_return('MAC verified OK')
          allow(Fastlane::Actions::CertificateExpirydateAction).to receive(:sh).with(%r{cat \.*\/test_certif  icate.p12 | openssl x509 -noout -enddate}).and_return('notAfter=Nov 20 15:20:20 2016 GMT')
        end

        it "THEN it returns the correct expiry date" do
          certificate_filepath = File.absolute_path("spec/fixtures/certificates/test_certificate.p12")
          actual_expirydate = Fastlane::FastFile.new.parse("lane :test do
            certificate_expirydate ({
              certificate_filepath: '#{certificate_filepath}',
              certificate_password: 'Fastlane'
            })
          end").runner.execute(:test)

          expect(actual_expirydate.strftime("%m/%d/%Y")).to eq(DateTime.parse("Nov 20, 2016").strftime("%m/%d/%Y"))
        end
      end

      context "WHEN calling action with an incorrect password" do
        before do
          allow(Fastlane::Actions::CertificateExpirydateAction).to receive(:sh).with(%r{openssl pkcs12 -in .*\/test_certificate.p12 -out .* -nodes -password pass:.*}).and_return('Mac verify error: invalid password?')
        end

        it "THEN it throws an error when an incorrect password is provided" do
          certificate_filepath = File.absolute_path("spec/fixtures/certificates/test_certificate.p12")
          certificate_expirydate_incorrect_pwd = "lane :test do
            certificate_expirydate ({
              certificate_filepath: '#{certificate_filepath}',
              certificate_password: 'Jenkins'
            })
          end"

          expect { Fastlane::FastFile.new.parse(certificate_expirydate_incorrect_pwd).runner.execute(:test) }.to(
            raise_error(FastlaneCore::Interface::FastlaneError) do |error|
              expect(error.message).to match(/Invalid password provided/)
            end
          )
        end
      end
    end
  end
end
