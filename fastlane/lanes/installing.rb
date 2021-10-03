desc 'Installs the certificates and installs the dependencies'
lane :install do
  match(readonly: true, type: 'development')
  match(readonly: true, type: 'appstore')
end
