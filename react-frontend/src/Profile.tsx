import { useState, useEffect } from 'react';
import type { User } from "./types/User.ts";
import UserForm from './UserForm.tsx';

function isUserInfoUserType(obj: any): obj is User {
  return obj && 'username' in obj && 'email' in obj;
}

export function Profile() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [userInfo, setUserInfo] = useState<User>();
  const jwtToken: string = document.cookie.split(';')[0].substring(4).trim();

  useEffect(() => {
    fetch('/api/v1/users/profile', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    }).then(Response => Response.json())
      .then((data) => {
        if (data.e) {
          console.log(data.e);
          setIsLoading(false);
          return;
        }

        setUserInfo(data.r);
        setIsLoading(false);
      });
  }, [])

  return <>
    {isLoading
      ? <><div>Profile not found.</div></>
      : <>
        {isUserInfoUserType(userInfo)
          ? <div className="row-start-2 row-span-full col-span-7 xl:col-span-6 border border-1 xl:ml-2 mb-2">
            <div className="grid place-items-center w-full h-full">
              <div className="size-128 border border-1">
                <div className="text-center w-full h-fit my-4">
                  <h2 className="text-2xl">User Profile</h2>
                </div>
                <UserForm />
              </div>
            </div>
          </div>
          : <> {/* TODO: On error, log it on the BE. */}</>
        }
      </>
    }
  </>
}
