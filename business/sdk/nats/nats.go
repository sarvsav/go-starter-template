// Package nats provides a NATS client for accessing nats server.
package nats

import "github.com/nats-io/nats.go"

// Config is the configuration for the NATS client.
type Config struct {
	// URL is the URL of the NATS server.
	NatsURL string
}

// Connect will open a connection to the NATS server.
func Connect(cfg Config) (*nats.Conn, error) {
	nc, err := nats.Connect(cfg.NatsURL)
	if err != nil {
		return nil, err
	}
	defer func() {
		_ = nc.Drain() // It makes clear that error is intentionally ignored.
	}()

	return nc, nil
}

// StatusCheck will check the status of the NATS connection.
func StatusCheck(nc *nats.Conn) string {
	switch nc.Status() {
	case nats.CONNECTED:
		return "connected"
	case nats.CLOSED:
		return "closed"
	case nats.RECONNECTING:
		return "reconnecting"
	default:
		return "unknown"
	}
}
