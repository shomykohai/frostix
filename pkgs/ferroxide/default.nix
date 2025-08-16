{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ferroxide";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-GShbqcsfM2Wx4Ge4pmdgAUhXIsQSxlG+WE3VKda8ZoU=";
  };

  vendorHash = "sha256-YjJdC0ZXNLAUbCoK4L2h0B4EG4y+iYKcTudJkAiOItU=";

  doCheck = false;

  subPackages = ["cmd/ferroxide"];

  meta = with lib; {
    description = "Third-party, open-source ProtonMail bridge (fork of hydroxide)";
    homepage = "https://github.com/acheong08/ferroxide";
    license = licenses.mit;
    mainProgram = "ferroxide";
  };
}
