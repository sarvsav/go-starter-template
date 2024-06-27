---
slug: understanding-and-integrating-nats
title: Understanding and Integrating NATS
authors: [sarvsav]
tags: [nats]
---

[![NATS](./nats-horizontal-color.png)](https://nats.io/)

## What is nats?

**NATS** is not only a queue system. It is released in the same year as `kafka` had been released and it is a mature project. The project was rewritten in `go` and support many functionalities. For our case, we will add it for publisher and subscriber pull consumer pattern using jetstream and maybe for service discovery also.

**nats JetStream** adds persistent storage ability to the nats core. Without it, nats was just pure pub/sub pattern or request/reply pattern. It also handles fault tolerance. The exactly one deliveres will be very helpful in banking system.

## Structure

Inspired from Bill Kennedy [service project](https://github.com/ardanlabs/service).

- business/sdk/nats/nats.go - will be responsible to return the nats client to connect to nats server

## Resources

Explore more about NATS on [nats-by-example](https://natsbyexample.com/).
