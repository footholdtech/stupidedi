module Stupidedi
  module Guides
    module FortyTen
      module X12

        b = GuideBuilder
        d = Schema
        r = SegmentReqs
        e = ElementReqs
        s = Versions::FunctionalGroups::FortyTen::SegmentDefs
        t = Versions::FunctionalGroups::FortyTen::TransactionSetDefs

        #
        # Purchase Order
        #
        AR943 = b.build(t::AR943,
          d::TableDef.header("Heading",
            b::Segment(10, s:: ST, "Transaction Set Header", r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Set Identifier Code", b::Values("943")),
              b::Element(e::Required,    "Transaction Set Control Number")),

            b::Segment(20, s::W06, "Warehouse Shipment Identification", r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Reporting Code", b::Values("F", "U")),
              b::Element(e::Situational,    "Depositor Order Number"),
              b::Element(e::Situational,    "Date"), 
              b::Element(e::Situational,    "Shipment Identification Number"),
            ),

            d::LoopDef.build("N1", d::RepeatCount.bounded(200),
              b::Segment(140, s:: N1, "Name", r::Situational, d::RepeatCount.bounded(3),
                b::Element(e::Required,    "Entity Identifier Code", b::Values("WH")),
                b::Element(e::Required,    "Name"),
                b::Element(e::Situational, "Identification Code Qualifier", b::Values("91")),
                b::Element(e::Situational, "Identification Code")),

            ),

            b::Segment(110, s::G62, "Date/Time Reference", r::Situational, d::RepeatCount.bounded(2),
              b::Element(e::Required,    "Date/Time Qualifier", b::Values("002")),
              b::Element(e::Situational,    "Date")),

            b::Segment(130, s::W27, "Carrier Detail", r::Situational, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transportation Method/Type Code", b::Values("M", "R")),
              b::Element(e::Situational, "Standard Carrier Alpha Code"),
              b::Element(e::Situational, "Shipment Method of Payment", b::Values("CC", "PP")),
              b::Element(e::Situational, "Equipment Initial"),
              b::Element(e::Situational, "Equipment Number")
            )



          ),
          
          d::TableDef.header("Detail",
            d::LoopDef.build("W04", d::RepeatCount.bounded(100000),
              b::Segment(10, s::W04, "Baseline Item Data", r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Situational,    "Item Detail Total"),
                b::Element(e::Situational,    "Unit or Basis for Measurement Code", b::Values("CS", "EA", "IP", "PL")),
                b::Element(e::Optional,       "U.P.C. Case Code"),
                b::Element(e::Situational,    "Product/Service ID Qualifier", b::Values("VN")),
                b::Element(e::Situational,    "Product/Service ID")
              )
            ),
            d::LoopDef.build("N9", d::RepeatCount.bounded(1000),
              b::Segment(50, s::N9, "Reference Identification", r::Situational, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Reference Identification Qualifier", b::Values("LI")),
                b::Element(e::Required,    "Reference Identification")
              )
            )
          ),


          d::TableDef.header("Summary",
            b::Segment(10, s::W03, "Total Shipment Information", r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Number of Units Shipped"),
            ),
            b::Segment(30, s::SE, "Transaction Set Trailer", r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Number of Included Segments"),
              b::Element(e::Required,    "Transaction Set Control Number")
            )
          )
        )
      end
    end
  end
end
