//
//  ChannelReference.swift
//  StreamChatClient
//
//  Copyright © 2020 Stream.io Inc. All rights reserved.
//

import Foundation

struct ChangeMatadata {
    /// This change is done only locally and is not confirmed from the backend. You can use it for optimistic UI updates.
    let isPendingWrite: Bool
    
    /// Tha data comes from the local storage. Another update with the live data from the backend may came momentarily.
    let isFromLocalCache: Bool
}

class ChannelReference: Reference {
    struct Snapshot {
        let metadata: ChangeMatadata
        let channel: Channel
        let messages: [Message]
        let members: [Member]
        let watchers: [Member]
    }

    weak var delegate: ChannelReferenceDelegate?

    /// Loads the current data snapshot for this channel.
    func read(completion: (_ data: Result<Snapshot, Error>) -> Void) -> Cancellable { C() }

    // Actions

    func send(message: Message, completion: ((Error?) -> Void)? = nil) -> Cancellable { C() }
    func send(action: Attachment.Action, for ephemeralMessage: Message, completion: (Error?) -> Void) -> Cancellable { C() }
    func send(event: TypingEvent, completion: ((Error?) -> Void)? = nil) -> Cancellable { C() }
    func send(image: ImageUpload, completion: ((Error?) -> Void)? = nil) -> Cancellable { C() }
    func send(file: FileUpload, completion: ((Error?) -> Void)? = nil) -> Cancellable { C() }

    func startWatchingChannel(options: QueryOptions, completion: (Error?) -> Void) -> Cancellable { C() }
    func stopWatchingChannel(options: QueryOptions, completion: (Error?) -> Void) -> Cancellable { C() }
    
    func load(pagination: Pagination, completion: (Error?) -> Void) -> Cancellable { C() }
    
    func delete(image: URL, completion: (Error?) -> Void) -> Cancellable { C() }
    func delete(file: URL, completion: (Error?) -> Void) -> Cancellable { C() }

    func hide(clearHistory: Bool = false, completion: (Error?) -> Void) -> Cancellable { C() }
    func show(completion: (Error?) -> Void) -> Cancellable { C() }
    
    func ban(member: Member, completion: (Error?) -> Void) -> Cancellable { C() }
    func add(members: Set<Member>, completion: (Error?) -> Void) -> Cancellable { C() }
    func remove(members: Set<Member>, completion: (Error?) -> Void) -> Cancellable { C() }
    
    func invite(members: Set<Member>, completion: (Error?) -> Void) -> Cancellable { C() }
    func acceptInvite(with message: Message? = nil, completion: (Error?) -> Void) -> Cancellable { C() }
    func rejectInvite(with message: Message? = nil, completion: (Error?) -> Void) -> Cancellable { C() }
    
    func markRead(completion: (Error?) -> Void) -> Cancellable { C() }
    func update(name: String? = nil,
                imageURL: URL? = nil,
                exatraData: ChannelExtraDataCodable? = nil,
                completion: (Error?) -> Void) -> Cancellable { C() }
    func delete(completion: (Error?) -> Void) -> Cancellable { C() }
}

protocol ChannelReferenceDelegate: AnyObject {
    func channelDataUpdated(_ reference: ChannelReference, data: Channel, metadata: ChangeMatadata)
    
    func messagesChanged(_ reference: ChannelReference, changes: [Change<Message>], metadata: ChangeMatadata)

    func didReceiveChannelEvent(_ reference: ChannelReference, event: ChannelEvent, metadata: ChangeMatadata)
    func didReceiveTypingEvent(_ reference: ChannelReference, event: TypingEvent, metadata: ChangeMatadata)
    func didReceiveMemeberEvent(_ reference: ChannelReference, event: MemberEvent, metadata: ChangeMatadata)
}

enum Change<T> {
    case added(_ item: T)
    case updated(_ item: T)
    case moved(_ item: T)
    case removed(_ item: T)
}


// ======================= END =======================












// ======================= just for code completion =======================

extension Reference {
    // ??
    func createChannel(users: [User], completion: (Result<ChannelReference, Error>) -> Void) -> Void {
    }
    
    func channelReference(channelId: String) -> ChannelReference {
        .init(client: client)
    }
    
    func channelReference(channelResponse: ChannelResponse) -> ChannelReference {
        .init(client: client)
    }

}

typealias ChannelEvent = Event
typealias TypingEvent = Event
typealias MemberEvent = Event

typealias ImageUpload = Void
typealias FileUpload = Void

struct C: Cancellable {
    func cancel() { }
}
