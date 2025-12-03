import { useState, useEffect } from 'react'
import { useParams } from 'react-router'
import type { Ticket } from './types/Ticket.ts'

export function DisplayTicket() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState<Ticket>();
  const ticket_id: Number = Number(useParams().ticket_id);

  useEffect(() => {
    const jwtToken: string = document.cookie.split(';')[0].substring(4).trim();
    fetch(`/api/v1/tickets/${ticket_id}`, {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    }).then(Response => Response.json())
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
  }, []);

  return <>
    <div className="w-full h-full p-4">
      {isLoading
        ? (<div>is Loading...</div>)
        : (
          <div className="flex flex-col gap-y-4">
            <h2 className="text-center text-3xl font-semibold p-2">
              {ticketData?.title} - {ticketData?.ticket_type.name}
            </h2>
            <div className="text-xl py-1 px-2 border border-1 rounded-xl">
              <h3 className="text-2xl text-center">
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
        )
      }
    </div >
  </>
}
