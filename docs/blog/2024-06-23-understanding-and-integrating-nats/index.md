---
slug: understanding-and-integrating-nats
title: Understanding and Integrating NATS
authors: [sarvsav]
tags: [nats]
---

[![NATS](./nats-horizontal-color.png)](https://nats.io/)

## What is nats?

**NATS** is not only a queue system. It is released in the same year as `kafka` had been released and it is a mature project. The project was rewritten in `go` and support many functionalities. For our case, we will add it for publisher and subscriber pull consumer pattern using jetstream and for service discovery also.

**nats JetStream** adds persistent storage ability to the nats core. Without it, nats was just pure pub/sub pattern or request/reply pattern. It also handles fault tolerance. The exactly one deliveres will be very helpful in banking system.

NATS is accepted as a cloud native messaging system and part of the [CNCF](https://landscape.cncf.io/stats?item=app-definition-and-development--streaming-messaging--nats).

## Why nats?

As per the [reactive manifesto](https://www.reactivemanifesto.org/), the system should be responsive, resilient, elastic, and message driven. And, to design a reactive system, we need a message driven system for managing the **east-west traffic**. The east-west traffic is the traffic between the services. The nats is a good choice for this. It is a lightweight, high performance, and easy to use messaging system.

And, the **north-south traffic** is the traffic between the client and the services. For this, we can use the `grpc`, `rest`, `websockets`, `graphql`.

## An example of message driven system - Currency value change in a game

Imagine a game, where you have a currency example gold and then you need to update it to platinum. This currency has been used in many components of the game, for example, in the shop, in invoices, in player profile etc. And, now with message driven system we update this publish this information and all the consumers will update their data. As well as, the old messages can be replayed to update the old data. Nats can also persist the data until the consumer has consumed it or come online.

## Patterns in nats

- **Request/Reply** - This is a synchronous pattern where the client sends a request and waits for the response. This is useful for the RPC pattern. It can be made asynchronous by using the `reply-to` subject.
- **Publish/Subscribe** - This is an asynchronous pattern where the client sends a message and the server receives it. This is useful for the event-driven pattern.
- **Queue** - This is a pattern where the message is sent to the queue and the consumer receives it. This is useful for the load balancing pattern.
- **JetStream** - This is a pattern where the message is stored in the persistent storage and can be replayed. This is useful for the exactly once delivery pattern.

Wildcards can be used in the subject. For example, `foo.*` will match `foo.bar` and `foo.baz`. And, `foo.>` will match `foo.bar`, `foo.bar.baz`, `foo.bar.baz.qux`.

## Quickstart with synadia cloud

For quickstart, we can use server from [Synadia Cloud](https://cloud.synadia.com/register).

On successful registration, we can get the server creds and context details.

```bash
$ nats context save --select "NGS-Default-CLI" \
        --server "tls://connect.ngs.global" \
        --creds "$HOME/etc/nats/cloud/creds/NGS-Default-CLI.creds"
NATS Configuration Context "NGS-Default-CLI"

      Server URLs: tls://connect.ngs.global
      Credentials: /home/sarvsav/etc/nats/cloud/creds/NGS-Default-CLI.creds (OK)
             Path: /home/sarvsav/.config/nats/context/NGS-Default-CLI.json
```

Test the connection by publishing and subscribing to the subject.

```bash
$ nats sub "welcome.>"
22:26:24 Subscribing on welcome.>
```

And, on other terminal run the below command.

```bash
nats pub "welcome.msg" "Welcome to Synadia Cloud"
```

And, to see the details of current context, we can use the below command.

```bash
nats context info --json
```

## Starting locally with jetstrams enabled

Use the [nats-server]() cli to start the server using config file having jetstream enabled. Create the file named `server.conf` in your `$HOME/etc/nats` directory.

```txt
// File: $HOME/etc/nats/server.conf
#General settings
host: 0.0.0.0
port: 4222

jetstream {
    # Jetstream storage location, limits and encryption
    store_dir: "/home/sarvsav/opt/nats/data/db"
}
```

And, use the below command to start nats with jetstream. The naming `nats/data/db` is used as nats doesn't provide any default directory for jetstream. So, we are making it uniform as we have it for [mongodb as /data/db](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.dbPath).

```bash
nats-server -config $HOME/etc/nats/server.conf
```

## Structure

Inspired from Bill Kennedy [service project](https://github.com/ardanlabs/service).

- business/sdk/nats/nats.go - will be responsible to return the nats client or jetstream to connect to nats server

## UI

A UI interface can be accessed using [NUI](https://github.com/nats-nui/nui).

## Resources

Explore more about NATS on [nats-by-example](https://natsbyexample.com/).
