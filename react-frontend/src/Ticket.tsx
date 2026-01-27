import { useState, useEffect, useRef, useOptimistic, type Dispatch } from 'react'
import { useParams } from 'react-router'
import { fetchApi } from './utils/fetchapi.ts';
import type { Ticket } from './types/Ticket.ts';
import { TicketPost } from './TicketPost.tsx';
import type { Post } from './types/Post.ts';

type PostsThreadProps = {
  posts?: Post[],
  addPosts: ({ body }: Post) => Promise<void>
};

function PostsThread({ posts, addPosts }: PostsThreadProps) {
  const [optimisticPosts, addOptimisticPosts] = useOptimistic(posts ?? [], (state, newPost: string) => [
    ...state, { body: newPost }
  ])

  async function postsAction(formData: FormData) {
    const new_post: Post = {
      body: String(formData.get("new_post"))
    };

    addOptimisticPosts(new_post.body)
    await addPosts(new_post)
  }

  return <>
    <div className="flex-grow flex flex-col overflow-hidden gap-4 p-4">
      {optimisticPosts ? optimisticPosts.map((o, i) => <TicketPost key={i} body={o.body} username={o.user} />) : null}
    </div>
    <div className="sticky h-124 bottom-0 border-t-1 rounded-xl shadow-md bg-white p-2">
      <form method="POST" action={postsAction}>
        <label htmlFor="new_post">New Post</label>
        <textarea className="w-full p-2 rounded-md resize-none bg-gray-200 focus:outline-none focus:border-blue-500" rows={4} placeholder="Add to the ticket" name="new_post" id="new_post"></textarea>
        <div className="p-4">
          <button type="submit" className="px-4 py-2 bg-blue-500 text-white font-semibold rounded-lg">Submit</button>
        </div>
      </form>
    </div>
  </>
}

export function DisplayTicket() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState<Ticket>();
  const [PostData, setPostData] = useState<Post[]>();
  const ticket_id: number = Number(useParams().ticket_id);

  useEffect(() => {
    if (!ticket_id) {
      setIsLoading(false);
      return;
    }

    fetchApi(`/api/v1/tickets/${ticket_id}`, 'GET')
      .then((data) => {
        if (data.e) {
          setIsLoading(false);
          return;
        }

        if (!data.r) {
          setIsLoading(true);
          return;
        }

        setIsLoading(false);
        setTicketData(data.r);
        setPostData(data.r.posts)
      })
  }, [ticket_id]);

  async function addPost({ body }: Post) {
    let jwtToken: string | unknown = document.cookie.split(';')[0].substring(4).trim();
    fetch(`/api/v1/tickets/${ticket_id}/posts`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
        "Content-Type": 'application/json'
      },
      body: JSON.stringify({ post: { body: body } }),
    }).then(Response => Response.json())
      .catch(e => console.error('Failed to make fetch request', e))
      .then((data) => {
        document.getElementById('ticket_posts_errors').classList.toggle("hidden", !data.e)

        if (data.e) {
          document.getElementById('ticket_posts_errors').append('Post could not be saved.');
          return;
        }

        setPostData(prev => [...prev ?? [], { body: body, user: data.r.username }])
      })
  }


  return <>
    <div>
      {isLoading
        ? (<div>is Loading...</div>)
        : <> {!ticketData
          ? (<div>Choose Ticket...</div>)
          : (
            <div className="flex flex-col h-screen">
              <div className="sticky h-fit top-0 bg-white">
                <div className="text-xl py-1 px-2 border-b-1 rounded-xl shadow-md">
                  <h2 className="text-center text-3xl font-semibold p-2">
                    {ticketData?.title} - {ticketData?.ticket_type.name}
                  </h2>
                  <h3 className="text-2xl text-center h-fit">
                    Ticket Body
                  </h3>
                  <div>
                    {ticketData?.body}
                  </div>
                  <div className="text-right">
                    <span className="text-gray-700 text-xs" >{ticketData?.created_at}</span>
                  </div>
                </div>
              </div>
              <div className="hidden" id="ticket_posts_errors"></div>
              <PostsThread posts={PostData} addPosts={addPost} />
            </div>
          )
        }
        </>
      }
    </div >
  </>
}
