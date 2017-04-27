module Fastlane
  module Actions
    class CertificateExpirydateAction < Action
      def self.run(params)
        certificate_basename = File.basename(params[:certificate_filepath], File.extname(params[:certificate_filepath]))
        certificate_pem_file = File.join("/tmp", "#{certificate_basename}.pem")
        File.delete(certificate_pem_file) if File.exist?(certificate_pem_file)

        result = sh("openssl pkcs12 -in #{params[:certificate_filepath].shellescape} -out #{certificate_pem_file} -nodes -password pass:#{params[:certificate_password].shellescape}")
        UI.user_error!("Invalid password provided to get the expiry date of the certificate") if /Mac verify error: invalid password\?/ =~ result

        expirydate_string = sh("cat #{certificate_pem_file} | openssl x509 -noout -enddate")[/notAfter=(.*)/, 1]

        DateTime.parse(expirydate_string)
      end

      def self.description
        "Retrieves the expiry date of the given p12 certificate file"
      end

      def self.authors
        ["lyndsey-ferguson/ldferguson"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :certificate_filepath,
                                  env_name: "CERTIFICATE_EXPIRYDATE_CERTIFICATE_FILEPATH",
                               description: "The file path to the certificate file",
                                  optional: false,
                                      type: String,
                              verify_block: proc do |value|
                                UI.user_error!("Invalid or empty certificate filepath given to CertificateExpirydateAction. Pass using `certificate_filepath: 'path/to/certificate_file'`") if value.nil? || value.empty?
                                UI.user_error!("Non-existant certificate file for CertificateExpirydateAction given") unless File.exist?(value)
                              end),
          FastlaneCore::ConfigItem.new(key: :certificate_password,
                                  env_name: "CERTIFICATE_EXPIRYDATE_CERTIFICATE_PASSWORD",
                               description: "The passwork to unlock the certificate file",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.return_value
        "Returns when the certificate expires in a DateTime object"
      end

      def self.is_supported?(platform)
        %i[ios mac].include?(platform)
      end
    end
  end
end
