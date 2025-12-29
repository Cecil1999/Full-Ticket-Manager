import { useState, useEffect } from 'react';
import { fetchApi } from './utils/fetchapi.ts';
import type { User } from "./types/User.ts";
import UserForm from './UserForm.tsx';

function isUserInfoUserType(obj: any): obj is User {
  return obj && 'username' in obj && 'email' in obj;
}

export function Profile() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [userInfo, setUserInfo] = useState<User>();

  useEffect(() => {
    fetchApi('/api/v1/users/profile', 'GET')
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
              <div className="w-128 h-fit border border-1">
                <div className="text-center w-full my-4">
                  <h2 className="text-2xl">User Profile</h2>
                </div>
                <UserForm user={userInfo} />
              </div>
            </div>
          </div>
          : <> {/* TODO: On error, log it on the BE. */}</>
        }
      </>
    }
  </>
}
