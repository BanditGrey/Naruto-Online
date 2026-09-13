package Foundation.Worker
{
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class WorkerCompat
   {
      
      private static var _cachedWorkersSupported:Boolean;
      
      private static var _cached11dot5:Boolean;
      
      private static var _cachedWorkerClass:Class;
      
      private static var _cachedWorkerDomainClass:Class;
      
      private static var _cachedWorkerStateClass:Class;
      
      private static var _cachedMessageChannelClass:Class;
      
      private static var _cachedMessageChannelStateClass:Class;
      
      private static var _cachedConditionClass:Class;
      
      private static var _cachedMutexClass:Class;
      
      private static var _cachePrimed:Boolean = false;
      
      public function WorkerCompat()
      {
         super();
      }
      
      public static function get WorkersSupported() : Boolean
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return false;
      }
      
      public static function get Worker() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedWorkerClass;
      }
      
      public static function get WorkerDomain() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedWorkerDomainClass;
      }
      
      public static function get WorkerState() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedWorkerStateClass;
      }
      
      public static function get MessageChannel() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedMessageChannelClass;
      }
      
      public static function get MessageChannelState() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedMessageChannelStateClass;
      }
      
      public static function get Condition() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedConditionClass;
      }
      
      public static function get Mutex() : Class
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         return _cachedMutexClass;
      }
      
      public static function SetShareable(param1:ByteArray, param2:Boolean = true) : void
      {
         if(!_cachePrimed)
         {
            PrimeCache();
         }
         if(_cached11dot5)
         {
            Object(param1).shareable = param2;
         }
      }
      
      private static function PrimeCache() : void
      {
         _cachedWorkerClass = null;
         _cachedWorkerDomainClass = null;
         _cachedWorkerStateClass = null;
         _cachedMessageChannelClass = null;
         _cachedMessageChannelStateClass = null;
         _cachedConditionClass = null;
         _cachedMutexClass = null;
         _cachedWorkersSupported = false;
         _cached11dot5 = false;
         try
         {
            _cachedWorkerClass = getDefinitionByName("flash.system.Worker") as Class;
            _cachedWorkerDomainClass = getDefinitionByName("flash.system.WorkerDomain") as Class;
            _cachedWorkerStateClass = getDefinitionByName("flash.system.WorkerState") as Class;
            _cachedMessageChannelClass = getDefinitionByName("flash.system.MessageChannel") as Class;
            _cachedMessageChannelStateClass = getDefinitionByName("flash.system.MessageChannelState") as Class;
         }
         catch(e:Error)
         {
         }
         if(_cachedWorkerClass)
         {
            _cachedWorkersSupported = Object(_cachedWorkerClass).isSupported;
         }
         _cachePrimed = true;
      }
   }
}

