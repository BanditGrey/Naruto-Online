package Logics.Streamization.Mentorship
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TPost;
   import Logics.Mentorship.Elements.TInteractionLogInfo;
   import Logics.Mentorship.TInteractionLog;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TUnstreamizerInteractionLog extends TUnstreamizer
   {
      
      public function TUnstreamizerInteractionLog()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInteractionLog = null;
         var _loc7_:TInteractionLogInfo = null;
         var _loc8_:TPost = null;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TInteractionLog;
         _loc5_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TInteractionLogInfo();
            _loc9_ = param1.readUnsignedInt();
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Post,_loc9_) as TPost;
            if(_loc9_ != 0)
            {
               _loc7_.InteractionText = _loc8_.TemplateTaskFront;
               _loc7_.TextColor = _loc8_.TextColor;
               _loc7_.TextSize = _loc8_.TextSize;
               _loc7_.Obj = Json.decode(TUtilityString.FetchUTF(param1));
               _loc7_.FightReportID0 = param1.readUnsignedInt();
               _loc7_.FightReportID1 = param1.readUnsignedInt();
               _loc7_.Time = param1.readUnsignedInt();
               _loc6_.InteractionLogList.push(_loc7_);
            }
            _loc4_++;
         }
         _loc5_ = _loc6_.InteractionLogList.length;
         if(_loc5_ > 20)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_ - 20)
            {
               _loc6_.InteractionLogList.shift();
               _loc4_++;
            }
         }
         _loc6_.Sort();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

