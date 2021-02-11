package provision

import (
	"github.com/docker/machine/libmachine/drivers"
)

func init() {
	Register("Fedora", &RegisteredProvisioner{
		New: NewFedoraProvisioner,
	})
}

func NewFedoraProvisioner(d drivers.Driver) Provisioner {
	return &FedoraProvisioner{
		NewRedHatProvisioner("workstation-fedora", d),
	}
}

func (provisioner *FedoraProvisioner) CompatibleWithHost() bool {
	return provisioner.OsReleaseInfo.VariantID == provisioner.OsReleaseVariantID
}

type FedoraProvisioner struct {
	*RedHatProvisioner
}

func (provisioner *FedoraProvisioner) String() string {
	return "fedora"
}
