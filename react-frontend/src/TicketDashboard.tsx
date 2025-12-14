import { useParams, useNavigate } from "react-router"
import { useEffect, useState } from "react";
import { DisplayTicket } from "./Ticket";
import type { Ticket } from "./types/Ticket";
import { fetchApi } from "./utils/fetchapi";

// Rewrite this to be an actual "TICKET" entry to shut TS errors up.

interface TicketItemProps {
  id: Number,
  title?: string,
  label?: string,
  body?: string,
}

function TicketItem({ id, title, label, body }: TicketItemProps) {
  const navigate = useNavigate();
  const ticketLink = (ev: React.SyntheticEvent) => {
    if (!(ev.target instanceof HTMLButtonElement)) {
      return;
    }

    const id: string | undefined = ev.target.dataset['id'];

    if (!Number(id)) {
      //TODO: JS Logger.
      return;
    }

    navigate(`/tickets/${id}`);
  }

  return <>
    <button onClick={ticketLink} data-id={id} className="border-gray-400 border-b-1 px-2 py-4 w-full text-left hover:bg-gray-200">
      {title} - {body} - {label}
    </button>
  </>
}

function TicketList() {
  // TODO: REALLY need to extend fetch or something hate having to redo this every time.
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [ticketData, setTicketData] = useState<Array<Ticket>>([]);

  useEffect(() => {
    fetchApi('/api/v1/tickets', 'GET')
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
    {isLoading ? (<div>is Loading...</div>) : (ticketData.map((o, i) => (<TicketItem key={i} id={o.id} label={o.ticket_type.name} title={o.title} body={o.body} />)))}
  </>
}

export function TicketDashboard() {
  const navigate = useNavigate();
  const ticket_id: number = Number(useParams().ticket_id);

  const returnToTicketList = (ev: React.SyntheticEvent) => {
    if (!(ev.target instanceof HTMLButtonElement)) {
      return;
    }

    navigate('/tickets')
  };

  return <>
    {/* Small TicketDashboard View */}
    <div className="block xl:hidden col-start-1 col-span-7 xl:col-span-6 row-span-3">
      <div className="border border-1 relative">
        {ticket_id
          ? (
            <>
              <button onClick={returnToTicketList} className="w-fit p-2 top-2.5 left-2.5 z-10 absolute border border-gray-400 bg-blue-600 text-white hover:text-black hover:bg-gray-200 rounded-2xl">Ticket List</button>
              <DisplayTicket />
            </>
          )
          : <TicketList />
        }
      </div>
    </div>

    {/* Large TicketDashboard View */}
    <div className="hidden xl:block xl:col-start-1 xl:col-span-2 xl:row-span-2 xl:ml-2 xl:mb-2 xl:border xl:border-l xl:rounded-xl">
      <TicketList />
    </div>
    <div className="hidden xl:block xl:col-start-3 xl:col-span-4 xl:row-span-2 xl:mb-2 xl:border xl:border-1 xl:rounded-xl">
      <div>
        <DisplayTicket />
      </div>
    </div>

  </>
}
