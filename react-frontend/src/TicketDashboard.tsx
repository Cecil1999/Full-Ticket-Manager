import { useParams } from "react-router"
import { Ticket } from "./Ticket";
import { useEffect, useState } from "react";

// Rewrite this to be an actual "TICKET" entry to shut TS errors up.
interface TicketItemProps {
  title?: string,
  label?: string,
  body?: string,
}

function TicketItem({ title, label, body }: TicketItemProps) {
  return <>
    <div className="p-2">
      {title} - {body}
    </div>
  </>
}

function TicketList() {
  // TODO: REALLY need to extend fetch or something hate having to redo this every time.
  const jwtToken: string = document.cookie.split(';')[0].substring(4).trim();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState([]);

  useEffect(() => {
    fetch('/api/v1/tickets', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    }).then(Response => Response.json())
      .then((data) => {
        setTicketData(data.r);
        setIsLoading(false);
      })
      .catch(err => {
        console.error(err);
        setIsLoading(false);
      });
  }, [])
  return <>

    {isLoading ? (<div>is Loading...</div>) : (ticketData.map((o, i) => (<TicketItem key={i} title={o.title} body={o.body} />)))}
  </>
}

export function TicketDashboard() {
  const ticket_id: number = Number(useParams().ticket_id);
  const jwtToken: string = document.cookie.split(';')[0].substring(4).trim();

  const retriveTicketInfo = (id: Number) => {
    fetch(`/api/v1/tickets/${id}`, {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    }).then(Response => Response.json())
      .then((data) => {
        if (data.e) {
          console.log(data.e);
          return;
        }

        console.log(data.r);
      })
  }

  return <>
    {/* Small TicketDashboard View */}
    <div className="block xl:hidden col-start-1 col-span-7 xl:col-span-6 row-span-3">
      <div className="border border-1">
        {ticket_id ? <Ticket /> : <TicketList />}
      </div>
    </div>

    {/* Large TicketDasahboard View */}
  </>
}
