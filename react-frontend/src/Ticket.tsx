import { useState, useEffect } from 'react'
import { useParams } from 'react-router'
import { fetchApi } from './utils/fetchapi.ts';
import type { Ticket } from './types/Ticket.ts'
import { Post } from './Post.tsx';

export function DisplayTicket() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState<Ticket>();
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
      })
  }, [ticket_id]);

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
              <div className="flex-grow flex flex-col overflow-hidden gap-4 p-4">
                {ticketData.posts?.map((o, i) => <Post key={i} body={o.body} user={o.user} />)}
              </div>

              <div className="sticky h-124 bottom-0 border-t-1 rounded-xl shadow-md bg-white p-2">
                <form>
                  <textarea className="w-full p-2 rounded-md resize-none bg-gray-200 focus:outline-none focus:border-blue-500" rows={4} placeholder="Add to the ticket"></textarea>
                  <div className="p-4">
                    <button type="submit" className="px-4 py-2 bg-blue-500 text-white font-semibold rounded-lg">Submit</button>
                  </div>
                </form>
              </div>
            </div>
          )
        }
        </>
      }
    </div >
  </>
}
