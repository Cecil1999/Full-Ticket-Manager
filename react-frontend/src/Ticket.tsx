import { useState, useEffect } from 'react'
import { useParams } from 'react-router'
import { fetchApi } from './utils/fetchapi.ts';
import type { Ticket } from './types/Ticket.ts'

export function DisplayTicket() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState<Ticket>();
  const ticket_id: Number = Number(useParams().ticket_id);

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
    <div className="w-full h-full p-4">
      {isLoading
        ? (<div>is Loading...</div>)
        : <> {!ticketData
          ? (<div>Choose Ticket...</div>)
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
        </>
      }
    </div >
  </>
}
