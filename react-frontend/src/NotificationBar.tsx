import { useEffect, useState } from "react";
import { fetchApi } from "./utils/fetchapi";
import type { Notification } from "./types/Notification.ts";
import { NotificationCard } from "./Notification.tsx";

export function NotificationBar() {
  const [notification, setNotification] = useState<Notification[]>([]);

  useEffect(() => {
    const fetchNotification = () => {
      fetchApi('/api/v1/notifications', 'GET')
        .then((data) => {
          if (data.e) {
            console.log('Error');
            return;
          }

          if (data.r) {
            setNotification(data.r);
          }
        });
    }

    const intervalId = setInterval(fetchNotification, 5000);

    return () => clearInterval(intervalId);
  }, []);


  const constructNotificationList = (notification: Notification[]) => {
    return <>
      {
        notification.filter((o) => Boolean(o)).map((o, i) => {
          <NotificationCard key={i} {...o} />
        })
      }
    </>
  };

  const extendSmallNotificationMenu = () => {
    const smallMenuDiv: HTMLElement = document.getElementById('notificationMenu')!;

    if (!smallMenuDiv) {
      console.log("Menu not found?");
      return;
    }

    const isSmallMenuDivExtended: boolean = smallMenuDiv.classList.contains('absolute')

    smallMenuDiv.classList.toggle('absolute', !isSmallMenuDivExtended);
    smallMenuDiv.classList.toggle('hidden', isSmallMenuDivExtended);
  }

  return <>
    <div className="absolute top-0 right-0 px-4 py-2 2xl:hidden">
      <span id="notificationBell" onClick={extendSmallNotificationMenu}>
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" className="bi bi-bell" viewBox="0 0 16 16">
          <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6" />
        </svg>
      </span>
    </div>
    <div className="hidden right-0 text-left flex flex-col w-64 h-96 overflow-y-auto z-10 bg-gray-200 border border-1 rounded-xl 2xl:hidden" id="notificationMenu">
      {notification ? constructNotificationList(notification) : ''}
    </div>
    <div className="col-span-1 col-start-7 row-span-full row-start-1 m-2 border border-1 rounded-xl hidden 2xl:block">
      <div className="p-4">
        <h2 className="text-3xl text-center">Notifications</h2>
        <div className="border-b-1"></div>
        {notification ? constructNotificationList(notification) : ''}
      </div>
    </div>
  </>
}
