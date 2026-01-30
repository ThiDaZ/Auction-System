# Auction-System

A simple Jakarta EE-based auction demo application (server + web client) providing live auctions, bidding, and real-time updates via JMS + WebSocket.

## Overview

- Purpose: Demonstration/prototype of a live auction platform with in-memory data, WebSocket real-time updates, and JMS integration for broadcasting events.
- Main technologies: Jakarta EE (EJB, Servlets, WebSocket, JMS), Java 11, Maven, ActiveMQ (JMS broker), Gson (JSON), Tailwind CSS + vanilla JS for frontend.

## File hierarchy

Root layout (key files and folders):

```
pom.xml
core/
  pom.xml
  src/main/java/lk/thidas/ee/core/
    dto/
      PlaceBid_DTO.java
      Response_DTO.java
      User_DTO.java
    model/
      AuctionItem.java
      Bidder.java
      User.java
ejb/
  pom.xml
  src/main/java/lk/thidas/ee/ejb/
    bean/
      AuctionManagerBean.java
      AuctionScheduler.java
      BidManagerBean.java
      UserManagerBean.java
    mdb/
      AuctionMessageSender.java
    remote/
      AuctionService.java
      BidService.java
      UserService.java
web/
  pom.xml
  src/main/java/lk/thidas/ee/web/
    servlet/
      CheckSession.java
      GetAllAuction.java
      GetAuction.java
      LoginServlet.java
      PlaceBid.java
      SignUpServlet.java
    websocket/
      AuctionWebSocket.java
      SessionHandler.java
    mdb/
      AuctionUpdateMessageListener.java
    util/
      LocalDateTimeAdapter.java
  src/main/webapp/
    index.jsp
    login.jsp
    signup.jsp
    single-auction.jsp
    assets/
      scripts/
        auctionItems.js
        auctionWebSocket.js
        bidPlace.js
        session.js
        singleAuction.js
    components/
      alertMessage.jsp
      auctionStateCards.jsp
      header.jsp
ear/
  pom.xml
```

## How it works (high level)

1. `AuctionManagerBean` holds auction items in memory and seeds sample items on startup.
2. `UserManagerBean` stores users in-memory and supports registration/login.
3. Clients use the web UI (JSP + JS) and call servlets (`/signIn`, `/signup`, `/getAllAuction`, `/getAuction?id=`, `/placeBid`).
4. `BidManagerBean.placeBid(...)` records bids in-memory and sends JSON messages to an ActiveMQ topic using `AuctionMessageSender`.
5. `AuctionUpdateMessageListener` (deployed in the web module) receives JMS topic messages and forwards them to connected WebSocket clients via `SessionHandler`.
6. `AuctionWebSocket` clients subscribe to a specific auction and receive real-time updates (highest bids, bid updates).

## Important files / entry points

- Backend EJBs: `ejb/src/main/java/.../bean/AuctionManagerBean.java`, `BidManagerBean.java`, `UserManagerBean.java`
- JMS Sender: `ejb/src/main/java/.../mdb/AuctionMessageSender.java`
- JMS Listener (web): `web/src/main/java/.../mdb/AuctionUpdateMessageListener.java`
- WebSocket: `web/src/main/java/.../websocket/AuctionWebSocket.java` (endpoint `/ws/auction`)
- Frontend pages: `web/src/main/webapp/index.jsp`, `single-auction.jsp`

## Build & run (local, minimal)

Prerequisites:

- Java 11
- Maven 3.x
- A Jakarta EE 9+ compatible application server (WildFly, Payara, GlassFish) or a server that supports Jakarta WebSocket and EJB modules
- ActiveMQ broker running (default configured broker URL: `tcp://localhost:61616`)

Example steps (local development):

1. Start ActiveMQ (example for Apache ActiveMQ standalone distribution):

```powershell
# extract and run activemq (example)
cd C:\path\to\apache-activemq-...
bin\activemq start
```

2. Build the multi-module project and create deployable artifacts:

```bash
mvn clean install
```

3. Deploy the generated EAR/WAR/EJB artifacts to your Jakarta EE server and start the server.

4. Open the web UI (example):

```
http://localhost:8080/auction/index.jsp
```

WebSocket example (client connects):

```
ws://localhost:8080/auction/ws/auction
```
