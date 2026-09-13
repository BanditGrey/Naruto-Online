package LocalStorages
{
   import flash.net.SharedObject;
   
   public class TLocalStoragelCore
   {
      
      protected var FSharedObject:SharedObject;
      
      protected var FData:Object;
      
      protected var FSavePath:String;
      
      protected var FMinDiskSpace:int;
      
      public function TLocalStoragelCore()
      {
         super();
         this.FSavePath = "";
         this.FMinDiskSpace = 0;
      }
      
      protected function FlushLocalStorage(param1:*) : void
      {
         var Data:* = param1;
         try
         {
            if(this.FSharedObject == null)
            {
               return;
            }
            this.FSharedObject.setProperty(this.FSavePath,Data);
            this.FSharedObject.flush(this.FMinDiskSpace);
         }
         catch(e:Error)
         {
         }
      }
      
      protected function FetchLocalStorage() : Object
      {
         var Data:Object = null;
         try
         {
            if(this.FSharedObject == null)
            {
               this.FSharedObject = SharedObject.getLocal(this.FSavePath);
            }
            Data = this.FSharedObject.data;
            if(Data != null)
            {
               this.FData = Data;
            }
         }
         catch(e:Error)
         {
         }
         return Data;
      }
      
      public function get Data() : Object
      {
         return this.FData;
      }
      
      public function get SavePath() : String
      {
         return this.FSavePath;
      }
      
      public function set SavePath(param1:String) : void
      {
         this.FSavePath = param1;
      }
      
      public function Flush(param1:*) : void
      {
         this.FlushLocalStorage(param1);
      }
      
      public function Fetch() : Object
      {
         return this.FetchLocalStorage();
      }
   }
}

