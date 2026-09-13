package Logics.Streamization.Characters
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.MoveRole.TRoleNpc;
   import Logics.DatebaseVO.VO.TNPC;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Processors.Game.Lobby.MainScene.Role.TUIRoleNpc;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerRoleNPC extends TUnstreamizer
   {
      
      protected var FBins:TBins;
      
      public function TUnstreamizerRoleNPC()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Digests(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Digests(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Database(param2,param3);
      }
      
      protected function UnstreamizationPerform_Database(param1:Object, param2:Object) : void
      {
         var _loc8_:TNPC = null;
         var _loc9_:TRoleNpc = null;
         var _loc10_:TUIRoleNpc = null;
         var _loc3_:Vector.<TUIRoleNpc> = param1 as Vector.<TUIRoleNpc>;
         var _loc4_:TUIComponent = param2 as TUIComponent;
         var _loc5_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NPC) as TBins;
         var _loc6_:int = _loc5_.Count;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc5_.GetDatebaseByIndex(_loc7_) as TNPC;
            _loc9_ = new TRoleNpc(0,0);
            _loc9_.RoleTemplateID = _loc8_.Identifier;
            _loc10_ = new TUIRoleNpc(_loc4_);
            _loc10_.ModuleId = CONST_MODULES.MODULE_Common;
            _loc4_.removeChild(_loc10_);
            this.SetDetails(_loc10_,_loc9_);
            _loc10_.RoleData = _loc9_;
            _loc3_.push(_loc10_);
            _loc7_++;
         }
      }
      
      protected function SetDetails(param1:TUIRoleNpc, param2:TRoleNpc) : void
      {
         var _loc3_:TNPC = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NPC,param2.RoleTemplateID) as TNPC;
         var _loc4_:TRoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,param2.RoleTemplateID) as TRoleModel;
         param2.RoleName = _loc3_.Name;
         param2.NpcTitle = _loc3_.NpcTitle;
         param2.NpcCityid = _loc3_.Cityid;
         param2.UserType = _loc3_.UserType;
         param2.NpcStartTime = _loc3_.StartTime;
         param2.NpcEndTime = _loc3_.EndTime;
         param2.NormalTalkText = _loc3_.Talk;
         param2.TownID = _loc3_.Cityid;
         param1.MapX = _loc3_.X;
         param1.MapY = _loc3_.Y;
         param1.TextrueID = _loc4_.Model;
         param1.NpcHeadTextureID = _loc4_.RoleHead;
         param1.NPcStyleTextureID = _loc4_.RoleStyle;
      }
   }
}

