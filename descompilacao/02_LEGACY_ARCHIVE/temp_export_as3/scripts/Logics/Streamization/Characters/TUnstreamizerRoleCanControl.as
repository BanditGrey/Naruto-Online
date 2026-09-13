package Logics.Streamization.Characters
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.MoveRole.*;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.*;
   
   public class TUnstreamizerRoleCanControl extends TUnstreamizer
   {
      
      public function TUnstreamizerRoleCanControl()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Properties(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TRoleCanControl = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TWing = null;
         _loc4_ = param2 as TRoleCanControl;
         _loc4_.RoleTemplateID = param1.readUnsignedInt();
         _loc4_.RoleName = TUtilityString.FetchUTF(param1);
         _loc4_.MilitaryRank = param1.readUnsignedInt();
         _loc4_.Level = param1.readUnsignedInt();
         _loc4_.FamilyID = param1.readUnsignedInt();
         _loc4_.RelexBoo = param1.readByte() == 0;
         _loc4_.TextureID = param1.readUnsignedInt();
         _loc4_.MapX = param1.readUnsignedShort();
         _loc4_.MapY = param1.readUnsignedShort();
         _loc4_.Quality = param1.readByte();
         _loc4_.NewShapeBaseHeroID = param1.readUnsignedInt();
         _loc4_.ChangeShape = _loc4_.NewShapeBaseHeroID != 0;
         _loc4_.TitleID = param1.readUnsignedInt();
         _loc4_.LittlePetID = param1.readUnsignedInt();
         _loc4_.LittlePetID = param1.readUnsignedInt();
         _loc4_.Wing.WingID = param1.readUnsignedInt();
         _loc4_.Wing.TransformID = param1.readUnsignedInt();
         _loc4_.Wing.HideWing = param1.readInt();
         _loc4_.Wing.HideWing = _loc4_.Wing.TransformID == 0 ? 1 : _loc4_.Wing.HideWing;
         _loc4_.JadeID = param1.readUnsignedInt();
         _loc4_.BadgeList.length = 0;
         _loc7_ = param1.readShort();
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_.BadgeList[_loc8_] = param1.readUnsignedInt();
            _loc8_++;
         }
      }
      
      protected function UnstreamizationPerform_Propertiesback(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TRoleCanControl = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = param2 as TRoleCanControl;
         _loc5_ = int(param1.readUnsignedShort());
         _loc6_ = int(param1.readUnsignedInt());
         _loc4_.RoleName = TUtilityString.FetchUTF(param1);
         _loc4_.MilitaryRank = param1.readUnsignedInt();
         _loc4_.RelexBoo = param1.readByte() == 0;
         _loc4_.TextureID = param1.readUnsignedInt();
         _loc4_.MapX = param1.readUnsignedShort();
         _loc4_.MapY = param1.readUnsignedShort();
         _loc4_.Quality = param1.readByte();
         _loc4_.NewShapeBaseHeroID = param1.readUnsignedInt();
         _loc4_.ChangeShape = _loc4_.NewShapeBaseHeroID != 0;
         _loc4_.RoleTemplateID = this.GetTemplateIDByProfessionGender(_loc6_,_loc5_);
      }
      
      protected function GetTemplateIDByProfessionGender(param1:int, param2:int) : int
      {
         var _loc3_:TBaseHero = null;
         var _loc4_:TBins = null;
         var _loc5_:int = 0;
         _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.Count)
         {
            _loc3_ = _loc4_.GetDatebaseByIndex(_loc5_) as TBaseHero;
            if(_loc3_.Profession == param1 && _loc3_.Sex == param2)
            {
               return _loc3_.Identifier;
            }
            _loc5_++;
         }
         return 0;
      }
   }
}

